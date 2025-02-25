import random


DEFAULT_PROBABILITY = 0.7

options = {
    "global-decls":                     {"default": False, "type": "bool"},
    "auto_config":                      {"default": True, "type": "bool"},  # use heuristics to automatically select solver and configure it
    "smt.case_split":                   {"default": 1, "type": "int", "valid_range": (0, 6)},  # Interval: 0 to 6
    "smt.delay_units":                  {"default": False, "type": "bool"},  # if true then z3 will not restart when a unit clause is learned
    "type_check":                       {"default": True, "type": "bool"},  # type checker (alias for well_sorted_check)
    "smt.mbqi":                         {"default": True, "type": "bool"},  # model based quantifier instantiation
    "pp.bv_literals":                   {"default": True, "type": "bool"},  # use Bit-Vector literals (e.g, #x0F and #b0101) during pretty printing
    "smt.qi.eager_threshold":           {"default": 10.0, "type": "float"},  # threshold for eager quantifier instantiation
    "smt.arith.solver":                 {"default": 6, "type": "int", "valid_range": (0, 6)},  # Interval: 0 to 6
    "smt.qi.max_multi_patterns":        {"default": 0, "type": "int"},  # specify the number of extra multi patterns
    "smt.phase_selection":              {"default": 3, "type": "int", "valid_range": (0, 7)},  # Interval: 0 to 7
    "proof":                            {"default": False, "type": "bool"},  # proof generation
    "sat.branching.heuristic":          {"default": "vsids", "type": "symbol", "valid_values": ["vsids", "chb"]},  # Possible values
    "sat.restart":                      {"default": "ema", "type": "symbol", "valid_values": ["static", "luby", "ema", "geometric"]},  # Possible values
    "sat.elim_vars":                    {"default": True, "type": "bool"},  # enable variable elimination using resolution during simplification
    "sat.local_search":                 {"default": False, "type": "bool"},  # use local search instead of CDCL
    "smt.arith.solver":                 {"default": 6, "type": "int", "valid_range": (0, 6)},  # Interval: 0 to 6
    "smt.arith.nl":                     {"default": True, "type": "bool"},  # branching on integer variables in non-linear clusters
    "smt.elim_unconstrained":           {"default": True, "type": "bool"},  # pre-processing: eliminate unconstrained subterms
}

# Function to generate SMT-LIB set-option commands
def generate_set_option(option_name, value):
    if option_name not in options:
        raise ValueError(f"Unknown option: {option_name}")
    
    option = options[option_name]
    option_type = option["type"]

    # Validate the value based on the type
    if option_type == "bool":
        if not isinstance(value, bool):
            raise ValueError(f"Invalid value for {option_name}: {value}. Expected a boolean.")
        value_str = "true" if value else "false"
    elif option_type == "int":
        if "valid_range" in option:
            min_val, max_val = option["valid_range"]
            if (min_val is not None and value < min_val) or (max_val is not None and value > max_val):
                raise ValueError(f"Invalid value for {option_name}: {value}. Must be in range {min_val} to {max_val}.")
        value_str = str(value)
    elif option_type == "float":
        value_str = str(value)
    elif option_type == "symbol":
        if "valid_values" in option and value not in option["valid_values"]:
            raise ValueError(f"Invalid value for {option_name}: {value}. Valid values are: {option['valid_values']}.")
        value_str = value
    else:
        raise ValueError(f"Unsupported type for option: {option_type}")

    return f"(set-option :{option_name} {value_str})"

def generate_random_option_combinations(num_combinations):
    option_combinations = []
    
    for _ in range(num_combinations):
        combination = []
        for option_name, option_details in options.items():
            if random.random() < DEFAULT_PROBABILITY:
                value = option_details["default"]
            else:
                if option_details["type"] == "bool":
                    value = random.choice([True, False])
                elif option_details["type"] == "int":
                    min_val, max_val = option_details.get("valid_range", (0, 10))
                    value = random.randint(min_val, max_val)
                elif option_details["type"] == "float":
                    min_val, max_val = option_details.get("valid_range", (0.0, 10.0))
                    value = random.uniform(min_val, max_val)
                elif option_details["type"] == "symbol":
                    value = random.choice(option_details["valid_values"])
                else:
                    raise ValueError(f"Unsupported type for option: {option_details['type']}")
            
            combination.append(generate_set_option(option_name, value))
        option_combinations.append(combination)
    
    return option_combinations

def encode_options_as_dict(config_list, options=options):
    features = []

    for config in config_list:
        feature_vector = {}
        for opt_name, opt_props in options.items():
            opt_type = opt_props['type']
            default_value = opt_props['default']
            
            chosen_value = None
            for opt in config:
                if f":{opt_name}" in opt:
                    chosen_value = opt.split()[-1].rstrip(')')
                    break
            
            # Encode based on type
            if opt_type == "bool":
                encoded_value = 1 if chosen_value == "true" else 0 if chosen_value == "false" else int(default_value)
            elif opt_type in ["int", "float"]:
                encoded_value = float(chosen_value) if chosen_value else float(default_value)
            elif opt_type == "symbol":
                for valid in opt_props["valid_values"]:
                    feature_vector[f"{opt_name}_{valid}"] = 1 if chosen_value == valid else 0
                continue
            else:
                encoded_value = 0
            
            # Add to feature vector
            feature_vector[opt_name] = encoded_value
        
        features.append(feature_vector)
    
    return features

def encode_options_as_arrays(config_list, options=options):
    features = []

    for config in config_list:
        feature_array = []
        for opt_name, opt_props in options.items():
            opt_type = opt_props['type']
            default_value = opt_props['default']
            
            chosen_value = None
            for opt in config:
                if f":{opt_name}" in opt:
                    chosen_value = opt.split()[-1].rstrip(')')
                    break
            
            # Encode based on type
            if opt_type == "bool":
                encoded_value = 1 if chosen_value == "true" else 0 if chosen_value == "false" else int(default_value)
                feature_array.append(encoded_value)
            elif opt_type in ["int", "float"]:
                encoded_value = float(chosen_value) if chosen_value else float(default_value)
                feature_array.append(encoded_value)
            elif opt_type == "symbol":
                for valid in opt_props["valid_values"]:
                    feature_array.append(1 if chosen_value == valid else 0)
            else:
                feature_array.append(0)
        
        features.append(feature_array)
    
    return features

def encode_default_options_as_dict(options=options):
    feature_vector = {}

    for opt_name, opt_props in options.items():
        opt_type = opt_props['type']
        default_value = opt_props['default']

        if opt_type == "bool":
            encoded_value = 1 if default_value else 0
            feature_vector[opt_name] = encoded_value
        elif opt_type in ["int", "float"]:
            feature_vector[opt_name] = float(default_value)
        elif opt_type == "symbol":
            for valid in opt_props["valid_values"]:
                feature_vector[f"{opt_name}_{valid}"] = 1 if default_value == valid else 0
        else:
            feature_vector[opt_name] = 0

    return feature_vector

def encode_default_options_as_array(options=options):
    feature_array = []

    for opt_name, opt_props in options.items():
        opt_type = opt_props['type']
        default_value = opt_props['default']

        # Encode based on type
        if opt_type == "bool":
            encoded_value = 1 if default_value else 0
            feature_array.append(encoded_value)
        elif opt_type in ["int", "float"]:
            feature_array.append(float(default_value))
        elif opt_type == "symbol":
            for valid in opt_props["valid_values"]:
                feature_array.append(1 if default_value == valid else 0)
        else:
            feature_array.append(0)  # Default for unsupported types

    return feature_array