# Dynamics

## Deterministic disese dynamics

Here we give an intuition of our fomulations.
Refer to PAPER for more exaustibe descirption.

We consider the epidemic model, given an ODE system ($SEIRDVX_{vac}$),
where for each time $t>0,$  $S$ (Susceptible), $E$ (Exposed),
$R$ (Recovered), $D$ (Death), $I_A$ (Asymptomatic Infected ),
$I_S$ (Symptomatic Infected), $V$ (vaccinated),
$X_{vac}$ (number of accumulative administered dosesuntil  $t$), 
satisfies  

```math
    \begin{aligned}
        S ^ {\prime} &= 
            \mu \hat{N} 
                + \omega_V V 
                + \delta_R R
                - (\lambda_f + \mu + \psi_V) S 
                \\
        E ^ {\prime} &= 
            \lambda_f S 
            + (1- \epsilon) V - (\mu + \delta_E) E
        \\
        I_S ^ {\prime} &=
            p \delta_E E - (\mu + \alpha_S) I_S
        \\
        I_A ^ {\prime}  &= 
            (1- p)\delta_E E - (\mu + \alpha_A) I_A
        \\
        R ^ {\prime} &= 
            (1- \theta) \alpha_S 
            + \alpha_A I_A 
            -(\mu + \delta_R) R
        \\
        D ^ {\prime} &=
            \theta \alpha_S I_S 
        \\
        V ^ {\prime} &= 
            \psi_V S 
                - [
                    (1 - \epsilon ) \lambda_f  
                    + \omega _V 
                    + \mu
                ] V
            \\
        X_{vac} ^ {\prime} &= \psi_V (S + E + I_A + R) 
        \\
        \lambda_f &:= 
            \frac{\beta_S I_S + \beta_A I_A}{\widehat{N}}
        \\
        \widehat{N}(t) &= 
                S(t) + E(t) + I_S(t) + I_A(t) + R(t) + D(t) + V(t)
    \end{aligned}
```
