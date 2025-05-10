extends Control

var course = ["IT", "IS" , "Course1" , "Course2"]
var num = ["1","2", "3","4"]
var institute 
var courseC
var year
var subID

var database : SQLite

func _ready():
	database = SQLite.new()
	database.path="res://data.db"
	database.open_db()

func ICETBTN():
	institute = "ICET"
	$%Course1.text = course[0]
	$%Course2.text = course[1]
	$%IBEG.hide()

func IBEGBTN():
	institute = "IBEG"
	$%Course1.text = course[2]
	$%Course2.text = course[3]
	$%ICET.hide()

func Course1():
	
	if institute == "ICET":
		courseC = "IT"
		$%btn1.text = "web development"
		$%btn2.text = "Database"
	else:
		courseC = "Course1"
		$%btn1.text = "Introduction to Research"
		$%btn2.text = "Math"
	$%Course2.hide()

func first():
	year = num[0]
	$"%2nd".hide()
	$"%3rd".hide()
	$"%4th".hide()

func second():
	year = num[1]
	$"%1st".hide()
	$"%3rd".hide()
	$"%4th".hide()

func third():
	year = num[2]
	$"%1st".hide()
	$"%2nd".hide()
	$"%4th".hide()


func fourth():
	year = num[3]
	$"%1st".hide()
	$"%2nd".hide()
	$"%3rd".hide()


func Course2():
	if institute == "ICET":
		courseC = "IS"
		$%btn1.text = "BPM"
		$%btn2.text = "System Analysis"
	else:
		courseC = "Course2"
		$%btn1.text = "Ethics"
		$%btn2.text = "Environmental Science"
	$%Course1.hide()

func _on_insert_pressed():
	addSubject()


func IDgenerator()-> int:
	randomize()  # Ensures more random results on each run
	return randi() % 900 + 100

func IDcheck():
	
	pass
 
func generate_three_digit_number()->int:
	randomize()  # Ensures more random results on each run
	return randi() % 900 + 100

func get_checkID():
	var maxattemp = 1000
	var switch = true
	var attemp = 0
	while maxattemp > attemp && switch == true:
		var id = str(generate_three_digit_number())
		var query = "SubID = '" + id + "'" 
		var check = database.select_rows("Subject",query, ["SubID"]) 
		if check.size() == 0:
			subID = id
			switch = false
		else:
			attemp +=1



func addSubject():
	get_checkID()
	var finalID = subID
	
	if year == null && courseC == null && institute == null:
		print("Invalid")
		reset()
	else:
		var data = {
			"SubID" = int(finalID),
			"Subject" = str($%Insert.text),
			"Course" = str(courseC),
			"Year" = str(year)
		}
		database.insert_row("Subject", data)
	reset()
	
	pass


func reset():
	$%btn1.text = ""
	$%btn2.text = ""
	$%Insert.text = ""
	$%Update.text = ""
	$%Course1.show()
	$%Course2.show()
	$%IBEG.show()
	$%ICET.show()
	$"%1st".show()
	$"%2nd".show()
	$"%3rd".show()
	$"%4th".show()
	$%Course1.text = ""
	$%Course2.text = ""
	institute = ""
	year = ""
	courseC = ""
	pass


func ResetBTn():
	reset()
	pass # Replace with function body.


func Exit():
	get_tree().change_scene_to_file("res://interface_4.tscn")
	pass # Replace with function body.


func BTN1():
	var sub = $%btn1.text
	get_checkID()
	var finalID = subID
	if year == null && courseC == null && institute == null:
		print("Invalid")
		reset()
	else:
		var data = {
			"SubID" = int(finalID),
			"Subject" = sub,
			"Course" = courseC,
			"Year" = year
		}
		database.insert_row("Subject",data)
		reset()



func BTN2():
	var sub = $%btn2.text
	get_checkID()
	var finalID = subID
	if year == null && courseC == null && institute == null:
		print("Invalid")
		reset()
	else:
		var data = {
			"SubID" = int(finalID),
			"Subject" = sub,
			"Course" = courseC,
			"Year" = year
		}
		database.insert_row("Subject",data)
		reset()
