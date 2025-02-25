class SExprTokenizer:
    def __init__(self, infile):
        self.file = open(infile, 'r')

    def __iter__(self):
        return self

    def __next__(self):
        token = self.tokenize()
        if token is None:
            self.file.close()
            raise StopIteration
        return token

    def tokenize(self):
        exprs = []
        cur_expr = None
        cur_quoted_symbol = []
        cur_comment = []
        cur_string_literal = []
        cur_token = None
        whitespace_chars = [' ', '\t', '\n']

        while True:
            char = self.file.read(1)
            if not char:
                break

            # Handle string literals
            if (char == '"' or cur_string_literal) and not cur_comment:
                cur_string_literal.append(char)
                # TODO: Escaped quotes "A "" B "" C" is one string literal
                if char == '"' and len(cur_string_literal) > 1:
                    assert cur_expr is not None
                    cur_expr.append(''.join(cur_string_literal))
                    cur_string_literal = []
                continue

            # Handle piped symbols
            if char == '|' or cur_quoted_symbol:
                if len(cur_comment) > 0:
                    continue
                cur_quoted_symbol.append(char)
                if char == '|' and len(cur_quoted_symbol) > 1:
                    # Piped symbols only appear in s-expressions
                    if cur_expr is None:
                        cur_expr = []
                    cur_expr.append(''.join(cur_quoted_symbol))
                    cur_quoted_symbol = []
                continue

            # Handle comments
            if char == ';' or cur_comment:
                cur_comment.append(char)
                if char == '\n':
                    comment = ''.join(cur_comment)
                    cur_comment = []
                    if cur_expr:
                        cur_expr.append(comment)
                    else:
                        return comment
                continue

            # Open s-expression
            if char == '(':
                # Check if token is not yet consumed
                if cur_token is not None:
                    cur_expr.append(''.join(cur_token))
                    cur_token = None

                cur_expr = []
                exprs.append(cur_expr)

            # Close s-expression
            elif char == ')':
                assert exprs
                assert cur_expr == exprs[-1]
                cur_expr = exprs.pop()

                # Check if token is not yet consumed
                if cur_token is not None:
                    cur_expr.append(''.join(cur_token))
                    cur_token = None

                # Do we have nested s-expressions?
                if exprs:
                    exprs[-1].append(tuple(cur_expr))
                    cur_expr = exprs[-1]
                else:
                    return tuple(cur_expr)

            # Start new token
            elif cur_token is None and char not in whitespace_chars:
                cur_token = [char]

            # Close current token
            elif cur_token and char in whitespace_chars:
                token = ''.join(cur_token)

                # Append token to current sexpr
                if cur_expr is not None:
                    cur_expr.append(token)
                else:
                    return token

                cur_token = None

            # Append to current token
            elif cur_token is not None:
                cur_token.append(char)
        assert not exprs
        assert cur_token is None
        return None

    def __del__(self):
        self.file.close()

import os
import time
from collections.abc import Iterable

from machsmt.util import die, warning
from .tokenize_sexpr import SExprTokenizer
from ..smtlib import grammatical_construct_list
from ..features import bonus_features
from ..config import args
from func_timeout import func_timeout, FunctionTimedOut

keyword_to_index = dict((grammatical_construct_list[i], i) for i in range(
    len(grammatical_construct_list)))

class Benchmark:
    def __init__(self, path: str):
        if not os.path.exists(path):
            raise FileNotFoundError(f"Could not find: {path}")
        self.path = path
        self.features = []
        self.logic = 'UNPARSED'
        self.parsed = False
        self.total_feature_time = 0.0

        self.solvers = {}
        self.scores = {}

    def get_path(self):
        return self.path

    def get_solvers(self):
        return sorted(self.solvers.values(), key=lambda p: p.get_name())

    def add_solver(self, solver, score):
        self.solvers[solver.get_name()] = solver
        self.scores[solver.get_name()] = score

    def get_score(self, solver):
        return self.scores[solver.get_name()]

    def get_logic(self): 
        return self.logic

    # Compute Features up to a timeout
    def compute_features(self):
        start = time.time()

        self.compute_core_features()

        if False and args.semantic:
            self.compute_semantic_features()

        self.total_feature_time = time.time() - start

    def compute_core_features(self):
        assert hasattr(self, 'tokens')

        self.features = [0] * (len(grammatical_construct_list) + 2)
        # benchmark file size
        self.features[-1] = float(os.path.getsize(self.path))

        def count_occurrences(sexprs, features):
            visit = sexprs[:]
            while visit:
                cur = visit.pop()
                if isinstance(cur, tuple):
                    visit.extend(cur)
                elif isinstance(cur, str):
                    if cur in keyword_to_index:
                        features[keyword_to_index[cur]] += 1
                else:
                    die(f"parsing error on: {self.path} {str(type(cur))}")

        try:
            func_timeout(timeout=args.feature_timeout,
                         func=count_occurrences,
                         args=(self.tokens, self.features))
        except FunctionTimedOut:
            warning(
                f'Timeout after {args.feature_timeout} seconds of compute_core_features on {self}')
            self.features[-2] = 1
        except RecursionError:
            print(f"Recurrsion Error on :{self}")

    def compute_semantic_features(self):
        assert hasattr(self, 'tokens')
        timeout = (args.feature_timeout / 2.0) / len(bonus_features)
        for feat in bonus_features:
            try:
                ret = func_timeout(timeout=timeout,
                                   func=feat,
                                   args=(self.tokens,))
                if isinstance(ret, Iterable):
                    for r in ret:
                        self.features.append(float(r))
                else:
                    self.features.append(float(ret))
            except (FunctionTimedOut, RecursionError): ## Current Crash on RecursionError ##'/home/joe/Desktop/smt-lib/non-incremental/AUFBV/20210301-Alive2-partial-undef/gcc/305_gcc.smt2'
                ret = feat([])
                if isinstance(ret, Iterable):
                    for r in ret:
                        self.features.append(-1.0)
                else:
                    self.features.append(-1.0)
                warning('Timeout after {} seconds of {} on {}'.format(
                    timeout, feat.__name__, self.path))

    # Get and if necessary, compute features.
    def get_features(self):
        return self.features

    def parse(self):
        assert not hasattr(self, 'tokens')
        self.tokens = [sexpr for sexpr in SExprTokenizer(self.path)]
        self.logic = 'UNSET_LOGIC'
        for sexpr in self.tokens:
            if len(sexpr) >= 2 and sexpr[0] == 'set-logic':
                self.logic = sexpr[1]
                break
        self.compute_features()
        del self.tokens
        assert not hasattr(self, 'tokens')

    def __str__(self): 
        return f"Benchmark(self.path={self.path}, len(self.solvers)={len(self.solvers)}, self.logic={self.logic})"
    __repr__ = __str__

    def __hash__(self):
        return hash(str(self))
        
def process_benchmark(benchmark):
    benchmark.parse()
    return benchmark

# if __name__ == '__main__':
#     tokenizer = SExprTokenizer("Dataset/LIA_NI/20190429-UltimateAutomizerSvcomp2019/jain_2_true-unreach-call_true-no-overflow_false-termination.i_1.smt2")
#     tokens = [sexpr for sexpr in tokenizer]
#         self.compute_features()
    
    # for sexpr in tokenizer:
    #     print("New")
    #     print(sexpr)
