import logging
import z3

LOG = logging.getLogger(__name__)

def evaluate_candidate_strategy(tester, strategy, smt_instances, max_timeout, best_tasks=None):

    tasks = []
    for i, smt_instance in enumerate(smt_instances):
        timeout = max_timeout
        if best_tasks is not None and best_tasks[i].is_solved():
            timeout = best_tasks[i].runtime
        if timeout < 1.0:
            timeout = 1.0
    tester.evaluate_parallel(tasks)
    return tasks

def evaluate_candidate_strategies(tester, strategies, smt_instances, max_timeout, best_tasks=None):


    if strategies is None:
        tasks = [smt_instance, None, None]
        ids = list(range(len(tasks)))
    else:
        tasks = []
        ids = []
        for strategy in strategies:
            for i, smt_instance in enumerate(smt_instances):
                timeout = max_timeout
                if best_tasks is not None and best_tasks[i] is not None and best_tasks[i].is_solved():
                    timeout = best_tasks[i].runtime + 0.5
                if timeout < 1.0:
                    timeout = 1.0
                ids.append(i)
                
    tester.evaluate_parallel(tasks)
    return zip(ids, tasks)

def toSMT2Benchmark(f, status="unknown", name="benchmark", logic=""):
    v = (z3.Ast * 0)()
    return z3.Z3_benchmark_to_smtlib_string(f.ctx_ref(), name, logic, status, "", 0, v, f.as_ast())

def goal_from_string(s):
    f = z3.parse_smt2_string(s)
    ret_goal = z3.Goal()
    ret_goal.add(f)
    return ret_goal

def goal_from_file(filename):
    f = z3.parse_smt2_file(filename)
    ret_goal = z3.Goal()
    ret_goal.add(f)
    return ret_goal