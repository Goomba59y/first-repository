extends Node

func write_json_data(file_path, data):
	var f = File.new()
	f.open_encrypted_with_pass(file_path, File.WRITE, "never gonna poop u up")
	if f.get_error() == OK:
		var err_code = f.store_string(JSON.print(data, "\t"))
		if err_code != OK:
			print("Wrote Data Successfully!!")
		else:
			print("Failed to write the Data to " + file_path)
			print(str(f.get_error()))
	else:
		print("Failed to open file, Error Code: " + str(f.get_error()))
	f.close()

func read_json_file(file_path):
	var f = File.new()
	f.open_encrypted_with_pass(file_path, File.READ, "never gonna poop u up")
	if f.get_error() == OK:
		var parsed_json = JSON.parse(f.get_as_text())
		if parsed_json.get_error() == OK:
			print("Parsed Json File Successfully!!")
			f.close()
			return parsed_json.result
		else:
			print("Failed to write the Data to " + file_path)
			print(parsed_json.get_error_string())
			print("At line: " + str(parsed_json.get_error_line()) + ", In the JSON File.")
	else:
		print("Failed to open file, Error Code: " + str(f.get_error()))
	f.close()
