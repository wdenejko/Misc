install.packages("sets")
packages(sets)

sets_options("universe", seq(from=0, to=140, by=0.1))

variables2 <-
set(odleglosc = fuzzy_variable(
		malaod = fuzzy_trapezoid(corners = c(-2, 0, 20, 45)), 
		sredniaod = fuzzy_trapezoid(corners = c(20, 45, 105, 130)), 
		duzaod = fuzzy_trapezoid(corners = c(105, 130, 130, 0))),
	predkosc = fuzzy_variable(
		mala = fuzzy_trapezoid(corners = c(-2, 0, 20, 65)), 
		srednia = fuzzy_trapezoid(corners = c(15, 65, 65, 115)), 
		duza = fuzzy_trapezoid(corners = c(65, 130, 130, 0))),
	przyspieszenie = fuzzy_variable(
		duzeminus = fuzzy_trapezoid(corners = c(-2, 0, 42, 70)), 
		maleminus = fuzzy_trapezoid(corners = c(42, 70, 70, 77)), 
		maleplus = fuzzy_trapezoid(corners = c(63, 70, 70, 98)), 
		duzeplus = fuzzy_trapezoid(corners = c(70, 98, 98, 0)))
)

rules2 <-
	set(
		fuzzy_rule(odleglosc %is% malaod && predkosc %is% mala, przyspieszenie %is% duzeminus ),
		fuzzy_rule(odleglosc %is% sredniaod && predkosc %is% mala, przyspieszenie %is% maleminus ),
		fuzzy_rule(odleglosc %is% duzaod && predkosc %is% mala, przyspieszenie %is% maleminus ),
		fuzzy_rule(odleglosc %is% malaod && predkosc %is% srednia, przyspieszenie %is% duzeplus ),
		fuzzy_rule(odleglosc %is% sredniaod && predkosc %is% srednia, przyspieszenie %is% maleminus ),
		fuzzy_rule(odleglosc %is% duzaod && predkosc %is% srednia, przyspieszenie %is% maleminus ),
		fuzzy_rule(odleglosc %is% malaod && predkosc %is% duza, przyspieszenie %is% maleplus ),
		fuzzy_rule(odleglosc %is% sredniaod && predkosc %is% duza, przyspieszenie %is% duzeminus ),
		fuzzy_rule(odleglosc %is% duzaod && predkosc %is% duza, przyspieszenie %is% maleminus )
		)

system2 <- fuzzy_system(variables2, rules2)
print(system2)
plot(system2)

fi <- fuzzy_inference(system2, list(odleglosc = 30, predkosc=50))
gset_defuzzify(fi, "centroid")
fi2 <- fuzzy_inference(system2, list(odleglosc = 100, predkosc=50))
gset_defuzzify(fi2, "centroid")
fi3 <- fuzzy_inference(system2, list(odleglosc = 30, predkosc=65))
gset_defuzzify(fi3, "centroid")
