"""
...
    load_parameters(json_file_name()

    Return a DataFrame with all parameters to
    run the MDP 
    Load parameters for the ODE mode and simulation.
    See table for a detailed description
# Arguments
- `json_file_name::String`: Path with a .json file of parameters
...
"""
function load_parameters(json_file_name="../data/parameters_model.json")
    file_JSON = open(json_file_name, "r")
    parameters = file_JSON |> JSON.parse |> DataFrame;
    close(file_JSON)
    return parameters
end
