using Pkg
Pkg.add("PkgTemplates")

using PkgTemplates

t = Template(;
    user="SaulDiazInfante",
    license = "MIT",
    authors=["Saul Diaz Infante Velasco", "Yofre Hernan Garcia Gomez"],
    plugins=[
        Travis(),
        Codecov(),
        Coveralls(),
        License(name="MIT"),
    ]
)

generate("VaccineStockManagementWithMDPs",t)
DocumenterTools.generate("VaccineStockManagementWithMDPs/docs")