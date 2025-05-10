extends Control



var institute
var course
var yearlv
var gender
var mm = "sdsd"
var studentID

var database : SQLite

func _ready():
	database = SQLite.new()
	database.path="res://data.db"
	database.open_db()



func generate_three_digit_number()->int:
	randomize()  # Ensures more random results on each run
	return randi() % 900 + 100

func _on_ibeg_button_up():
	$Panel2Prime/Panel2.show()

func _on_enroll_pressed():
	get_checkID()
	#================================
	var fname = $%Fname.text
	var lname = $%Lname.text
	var username = $%Username.text
	var password = $%Password.text
	var ID = studentID
	
	#================================================
	var data = {
		"StudentID" = int(ID),
		"FirstName" = str(fname),
		"LastName" = str(lname),
		"Gender" = str(gender),
		"YearLvL" = int(yearlv),
		"Course" = str(course),
		"Institute" = str(institute)
	}
	database.insert_row("StudentInfo", data)
	#====================================
	var data2 = {
		"StudentID" = int(ID),
		"Username" = str(username),
		"Password" = str(password)
	}
	database.insert_row("IdentifyStudent", data2)
	#=========================================
	var data3 ={
		"StudentID" = int(ID)
	}
	database.insert_row("Grade", data3)
	#==============================================
	var data4 ={
		"StudentID" = int(ID)
	}
	database.insert_row("Evaluation",data4)
	_on_reset_pressed()
	get_tree().change_scene_to_file("res://interface_1.tscn")


func _on_ibeg_pressed():
	$%PanelICET.hide()
	$%Course2.show()
	$%Course1.show()
	institute = "IBEG"

func _on_icet_pressed():
	$%PanelIBEG.hide()
	$%BSIT.show()
	$%BSIS.show()
	institute = "ICET"

func _on_course_1_pressed():
	$%Course2.hide()
	course = "Course1"

func _on_course_2_pressed():
	$%Course1.hide()
	course = "Course2"

func _on_bsit_pressed():
	$%BSIS.hide()
	course = "BSIT"

func _on_bsis_pressed():
	$%BSIT.hide()
	course = "BSIS"

#reset everytinh
func _on_reset_pressed():
	institute = ""
	course = ""
	yearlv = ""
	gender = ""
	
	#Course
	$%PanelIBEG.show()
	$%PanelICET.show()
	$%Course1.hide()
	$%Course2.hide()
	$%BSIS.hide()
	$%BSIT.hide()
	#YearLvL
	$"%1styear".show()
	$"%2ndyear".show()
	$"%3rdyear".show()
	$"%4thyear".show()
	#Gender
	$%Male.show()
	$%Female.show()
	$%Username.text = ""
	$%Password.text = ""
	$%Fname.text = ""
	$%Lname.text = ""

func _on_styear_pressed():
	$"%2ndyear".hide()
	$"%3rdyear".hide()
	$"%4thyear".hide()
	yearlv = "1"
	pass # Replace with function body.

func _on_ndyear_pressed():
	$"%1styear".hide()
	$"%3rdyear".hide()
	$"%4thyear".hide()
	yearlv = "2"
	pass # Replace with function body.

func _on_rdyear_pressed():
	$"%2ndyear".hide()
	$"%1styear".hide()
	$"%4thyear".hide()
	yearlv = "3"
	pass # Replace with function body.

func _on_thyear_pressed():
	$"%2ndyear".hide()
	$"%1styear".hide()
	$"%3rdyear".hide()
	yearlv = "4"
	pass # Replace with function body.

func _on_male_pressed():
	$%Female.hide()
	gender = "Male"
	pass # Replace with function body.

func _on_female_pressed():
	$%Male.hide()
	gender = "Female"



func get_checkID():
	var maxattemp = 1000
	var switch = true
	var attemp = 0
	while maxattemp > attemp && switch == true:
		var id = str(generate_three_digit_number())
		var query = "StudentID = '" + id + "'" 
		var check = database.select_rows("Reference",query, ["StudentID"]) 
		if check.size() == 0:
			studentID = id
			switch = false
		else:
			attemp +=1
	



func _on_button_pressed():
	get_checkID()
	print(studentID)
	pass # Replace with function body.


func exit():
	get_tree().change_scene_to_file("res://interface_1.tscn")
	pass # Replace with function body.
