# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

	KnowledgeArea.create([{name: 'Informatica'},{name: 'Otros'},{name: 'Liderazgo'},{name: 'Trabajo en equipo'}])


	v={"Abogado"=>[],
		"Administracion"=>["Escolar","Internacional", "Publica","y Direccion de Empresas","de Empresas"],
		"Agronomia"=>[],
		"Arquitecto"=>[],
	 "Artesano"=>[],
	 "Auditor"=>[],
	 "Auxiliar"=>["Contabilidad","de Oficina"],
	 "Ayudante de Gerencia"=>[],
	 "Bachiller"=>["En Humanidades"],
	 "Bachillerato Internacional"=>[],
	 "Bibliotecologo"=>[],
	 "Biologo"=>[],
	 "Bioquimico"=>[]
 }
Title.create([{name:"Abogado"},{name:"Administracion"},{name:"Agronomia"},{name:"Arquitecto"},{name:"Artesano"},{name:"Auditor"},{name:"Auxiliar"},{name:"Ayudante de Gerencia"},{name:"Bachiller"},{name:"Bibliotecologo"},{name:"Biologo"},{name:"Bioquimico"}])
abogado_id=Title.where(name:"Administracion").first.id
Degree.create({name: "Escolar",title_id:abogado_id},{name: "Internacional",title_id:abogado_id},{name: "Publica",title_id:abogado_id},{name: "Direccion de Empresas",title_id:abogado_id},{name: "De Empresas",title_id:abogado_id})
auxiliar_id=Title.where(name:"Auxiliar").first.id
Degree.crearte({name:"Contabilidad",title_id:auxiliar_id},{name:"de Oficina",title_id:auxiliar_id})
