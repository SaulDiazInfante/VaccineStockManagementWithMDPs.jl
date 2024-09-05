"""_summary_
"""
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.patches as patches

plt.style.use('dark_background')
#
DATA_FOLDER = "./data"
df = pd.read_csv("./data/df_solution.csv")
par = pd.read_json("./data/parameters_model.json")
time_line = df["time"]
START_DATE='2021-01-01'
time_line_date_in_days = pd.to_datetime(START_DATE) + \
    pd.to_timedelta(time_line.values, unit='D')
df["date"] = time_line_date_in_days
df = df.set_index('date')
#
states = [
    'S',
    'E',
    'I_S',
    #'I_A',
    'D',
    #'R',
    'V',
    'X_vac',
 #   'K_stock',
 #   'action'
]
N = par["N"][0]
df_states = N * df[states]
#
figure_states, axes_states = plt.subplots(
    figsize=(14, 8.7),
    nrows=2,
    ncols=3
)
df_states.plot(
    subplots=True,
    layout=(2, 2),
    ax=axes_states,
    sharex=True,
    label="deterministic",
    lw=1,
    legend=False
)

axes_states[0, 0].set_ylabel(r'$S$')
axes_states[0, 1].set_ylabel(r'$E$')
axes_states[0, 2].set_ylabel(r'$I_S$')
axes_states[1, 0].set_ylabel(r'$D$')
axes_states[1, 1].set_ylabel(r'$V$')
axes_states[1, 2].set_ylabel(r'$X_{vac}$')

plt.savefig("det_states.svg", dpi=300)
figure_states.tight_layout()
plt.show()

policy = [
    #'S',
    #'E',
    #'I_S',
    #'I_A',
    #'D',
    #'R',
    #'V',
    #'X_vac',
    'K_stock',
    'action'
]
#
df_policy = N * df[policy]
df_policy['opt_policy'] = df['opt_policy']
figure_policy, axes_policy = plt.subplots(
    figsize=(14, 8.7),
    nrows=3,
    ncols=1
)
df_policy.plot(
    subplots=True,
    layout=(2, 1),
    ax=axes_policy,
    sharex=True,
    label="deterministic",
    lw=1,
    # color='opt_policy',
    legend=False
)
#
axes_policy[0].set_ylabel(r'Stock (number of doses)')
axes_policy[1].set_ylabel(r'Vaccination rate $\Psi_v$')
axes_policy[2].set_ylabel(r'OP fraction of available Stock')
# Here I want a time line of decisions axes_policy[2]
plt.savefig("det_policy.png", dpi=300)
figure_policy.tight_layout()
plt.show()
#
df_actions = df_policy['opt_policy']