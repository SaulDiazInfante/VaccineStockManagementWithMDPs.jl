"""
<<<<<<< HEAD
...
    load_parameters(json_file_name()
=======
    load_parameters(json_file_name="../data/parameters_model.json")
>>>>>>> 2fb52a9a8263ae79e5720dea46bc965322e2703b

    Return a DataFrame with all parameters to
    run the MDP.

    This function also load parameters for the ODE model and 
    simulation setup.
    See table for a detailed description in the article.

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
