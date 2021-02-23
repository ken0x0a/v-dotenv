module env

// load `.env` => map[string]string
//
// ```v
// conf := load()  
// conf["YOUR_ENV_VAR"]
// ```
//
// Example: load()
pub fn load() map[string]string {
	mut file := $embed_file('.env')

	str := unsafe {
		cstring_to_vstring(file.data())
	}

	mut conf := map[string]string{}
	for line in str.split('\n') {
		if line.len < 3 {
			continue
		}

		key_val := line.split_nth('=', 2)
		conf[key_val[0]] = key_val[1]
		// os.setenv(key_val[0], key_val[1], true)
	}
	return conf
}
