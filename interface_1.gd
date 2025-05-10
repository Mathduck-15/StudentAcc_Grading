extends Control

var username
var password

var decide

var database : SQLite

func _ready():
	database = SQLite.new()
	database.path="res://data.db"
	database.open_db()


func loginAdmin():
	username = str($%UserIDTxT.text)
	password = str($%PasswordTxT.text)
	
	var passwordDB
	var log = database.query("select * from IdentityAdmin ")
	var user_name_value = username  # String UserID or username value
	var query = "Username = '" + user_name_value + "'"  # Add single quotes around string values
	var getpassword = database.select_rows("IdentityAdmin", query, ["Password"])  
	print(getpassword)
	
	if getpassword.size() > 0:
		var data = getpassword[0]
		# Access the "UserID" value from the dictionary
		passwordDB = data["Password"]
		print(passwordDB)
	
	if password == passwordDB:
		print("horray")
		get_tree().change_scene_to_file("res://interface_4.tscn")
	else:
		LoginStudent()

func ReferenceUpdate():
	var user_name_value = $"%UserIDTxT".text # String UserID or username value
	var query = "Username = '" + user_name_value + "'"
	var getUserID = database.select_rows("IdentifyStudent", query, ["StudentID"]) 
	var userID
	if getUserID.size() > 0:
		var ID_data = getUserID[0]
		userID = ID_data["StudentID"]
		print(database.update_rows("Reference", "ID = 1" , {"StudentID" :  + userID}))
		print("ok")
	

func LoginStudent():
	username = str($%UserIDTxT.text)
	password = str($%PasswordTxT.text)
	
	var passwordDB
	var log = database.query("select * from IdentifyStudent ")
	var user_name_value = username  # String UserID or username value
	var query = "Username = '" + user_name_value + "'"  # Add single quotes around string values
	var getpassword = database.select_rows("IdentifyStudent", query, ["Password"])  
	print(getpassword)
	
	if getpassword.size() > 0:
		var data = getpassword[0]
		# Access the "UserID" value from the dictionary
		passwordDB = data["Password"]
		print(passwordDB)
	
	if password == passwordDB:
		ReferenceUpdate()
		get_tree().change_scene_to_file("res://interface_2.tscn")
		print("yay2")
		
	else:
		$%Notification.show()
		$Notification.text = "Invalid Try Again"
	pass


func _on_login_pressed():
	loginAdmin()

func _on_signin_pressed():
	get_tree().change_scene_to_file("res://interface_3.tscn")
	pass # Replace with function body.
