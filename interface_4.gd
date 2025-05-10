extends Control

var midterm
var finals
var overall 
var result

var database : SQLite

func _ready():
	database = SQLite.new()
	database.path="res://data.db"
	database.open_db()

func StudentInfo():
	var studentID = $FindID.text
	var query = "StudentID = '" + studentID + "'" 
	
	
	var FirstName = database.select_rows("StudentInfo", query, ["FirstName"])
	if FirstName.size() > 0:
		var data = FirstName[0]
		$%Fname.text = str(data["FirstName"])
	
	var LastName = database.select_rows("StudentInfo", query, ["LastName"])
	if LastName.size() > 0:
		var data = LastName[0]
		$%Lname.text = str(data["LastName"])
	
	var Course =  database.select_rows("StudentInfo", query, ["Course"])
	if Course.size() > 0:
		var data = Course[0]
		$%CourseTxT.text = str(data["Course"])
	
	var YearLvL =  database.select_rows("StudentInfo", query, ["YearLvL"])
	var data = YearLvL[0] 
	$%YearLvLTxT.text = str(data["YearLvL"])
	
	var Institute =  database.select_rows("StudentInfo", query, ["Institute"])
	if Institute.size() > 0:
		var data1 = Institute[0]
		$%InstituteTxT.text = str(data1["Institute"])
	
	var Midterm =  database.select_rows("Grade", query, ["Midterm"])
	if Midterm.size() > 0:
		var data1 = Midterm[0]
		$%MidtermTxT.text = str(data1["Midterm"])
	
	var Finals =  database.select_rows("Grade", query, ["Finals"])
	if Finals.size() > 0:
		var data1 = Finals[0]
		$%FinalsTxT.text = str(data1["Finals"])
	
	var Overall =  database.select_rows("Evaluation", query, ["Overall"])
	if Overall.size() > 0:
		var data1 = Overall[0]
		$%OverallTxT.text = str(data1["Overall"])
	
	var Result =  database.select_rows("Evaluation", query, ["Result"])
	if Result.size() > 0:
		var data1 = Result[0]
		$%ResultTxT.text = str(data1["Result"])

func _on_search_pressed():
	var ID = $FindID.text
	var query = "StudentID = '" + ID + "'" 
	if database.select_rows("StudentInfo",query,["StudentID"] ) == []:
		$FindID.text = ""
		$FindID.placeholder_text = "ID not Found"
	else :
		StudentInfo()
	#

func calculategrade():
	midterm = int($Midterm.text)
	finals = int($Finals.text)
	overall = (midterm + finals)/2
	$%OverallTxT.text = str(overall)
	$%ResultTxT.text = ""
	
	if overall < 75:
		$Incomplete.show()
		$failed.show()
		$Approve.hide()
	else:
		$Approve.show()
		result = "pass"
		$%ResultTxT.text = str(result) 
	pass

func updateF_M():
	var studentID = $FindID.text
	var query = "StudentID = '" + studentID + "'" 
	database.update_rows("Grade", query, {"Midterm": int(midterm)})
	database.update_rows("Grade", query, {"Finals": int(finals)})
	database.update_rows("Evaluation", query, {"Overall": int(overall)})
	database.update_rows("Evaluation", query, {"Result": str("pass")})

func _on_calculate_pressed():
	calculategrade()

func _on_approve_pressed():
	updateF_M()
	$Approve.hide()
	reset()

func _on_failed_pressed():
	var studentID = $FindID.text
	var query = "StudentID = '" + studentID + "'" 
	database.update_rows("Grade", query, {"Midterm": int(midterm)})
	database.update_rows("Grade", query, {"Finals": int(finals)})
	database.update_rows("Evaluation", query, {"Overall": int(overall)})
	database.update_rows("Evaluation", query, {"Result": str("fail")})
	
	
	$Incomplete.hide()
	$failed.hide()
	$Approve.hide()
	reset()

func _on_incomplete_pressed():
	var studentID = $FindID.text
	var query = "StudentID = '" + studentID + "'" 
	database.update_rows("Grade", query, {"Midterm": int(midterm)})
	database.update_rows("Grade", query, {"Finals": int(finals)})
	database.update_rows("Evaluation", query, {"Overall": int(overall)})
	database.update_rows("Evaluation", query, {"Result": str("inc")})
	
	$Incomplete.hide()
	$failed.hide()
	$Approve.hide()
	reset()
	


func reset():
	$%Lname.text = ""
	$%Fname.text = ""
	$FindID.text = ""
	$%YearLvLTxT.text = ""
	$%CourseTxT.text = ""
	$%CourseTxT.text = ""
	$%MidtermTxT.text = ""
	$%FinalsTxT.text = ""
	$%OverallTxT.text = ""
	$%ResultTxT.text = ""
	$Midterm.text = ""
	$%Finals.text = ""
	pass


func _on_x_pressed():
	get_tree().change_scene_to_file("res://interface_1.tscn")
	pass # Replace with function body.


func _on_statistics_pressed():
	$Interface6.show()
	pass # Replace with function body.


func _on_hide_interface_pressed():
	$Interface6.hide()
	pass # Replace with function body.


func Subjects():
	get_tree().change_scene_to_file("res://interface_7.tscn")
	pass # Replace with function body.
