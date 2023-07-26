using Pkg
Pkg.add("PkgTemplates")

using PkgTemplates

t = Template(;
    user="SaulDiazInfante",
    authors=["Saul Diaz-Infante Veklasco", "Yofre Hernan Garcia Gomez"],
    plugins=[
        License(name="MIT"),
        Git(),
        GitHubActions(),
    ]
)

generate("VaccineStockManagementWithMDPs",t)
DocumenterTools.generate("VaccineStockManagementWithMDPs/docs")