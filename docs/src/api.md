# Functions to implement a nonstandard solver

## `get_interval_solution!(time_interval, x, opt_policy, a_t, k,parameters)`

From a point of solution of SEIRVD model $x$, a stock level $k$,
and the most recent parameters, this function evaluates the SEIRVD
solution for possible vaccine control *opt_policy* in each sequence of
time point of *time_ interval*.

## `get_path_plot(df_solution)`

From the solution stored in data frame $df_solution$, this function
returns the graph evolution of counter of each compartment in the  
$SEIRVDX_{vac}$ and the vaccine stock level evolution.

## `get_solution_path!(parameters)`

From of the parameters, this function returns the initial values and the
solution of $SEIRVDX_{vac}$ model.

## `get_stencil_projection(t, parameters)`

This function is implemented by computing

```math
\begin{aligned}
    \eta(t): = \sup
        \{
            i: t_i \leq t
    \}, \quad i \in \{1,2 , \dots, M \}
\end{aligned}
```

where the index $i$ runs over the projected
delivery times $t_i$.

## `get_stochastic_perturbation(son_file_name)`

For the arrive of inventory vaccine order return a new delivery time  
and the new size of this order. The new delivery time is simulated under
the hypothesis that the time between orders follows a normal
distribution with mean this time increment and standard deviation the
root of the same time increment. The new size of vaccine order is
simulated under the hypothesis that the size order follows a truncated
normal distribution with mean the size order $K_p$ that was previously
programed and the standard deviation is the half of the root of this
size programed order. The truncated normal is considered with support
$[0,2K_p]$.

## `get_vaccine_action!(X_C,t,parameters)`

Calculates at time $t,$ the possible percentage of vaccine coverage
population when the current inventory level of vaccines is $X_C$
according to size of time horizon.  

## `get_vaccine_stock_coverage(k, parameters)`

Returns el percentage of population to vaccine when the inventory level
of interest is $k$ and use the current parameters

## `load_parameters(json_file_name)`

The function access of the archive $json_file_name$ all initial
parameters of $SERIVDX_{vac}$ inventory model.

## `rhs_evaluation!(t, x, opt_policy,  a_t, k, parameters)`

The function evaluates the solution of $SERIVDX_{vac}$ inventory model
at time $t+1$ when the solution in the time $t$ is $x,$ is used the
value $opt_policy$ as policy, the available inventory level is $k$ and
the percentage to vaccine population is $a_t$ when $parameters$ are the
current parameters.

## `save_interval_solution(x,header_strs,file_name)`

The function save the array solution $x$ in a data frame with the
*header_strs* as headers and name df_solution. Also, the df_solution
is saved in CSV file with name *file_name*.

## `save_parameters_json(par,file_name)`

Save the data frame of parameters $par$ in the json file with name
*file_name* that concatenate to this the current date.
