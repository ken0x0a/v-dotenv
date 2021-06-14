module env

import os

// load `.env`
//
// ```v
// import env  
// import os  
//
// env.load()  
// os.getenv("YOUR_ENV_VAR")
// ```
//
// Example: load()
// Example: load("./path_to/.env")
pub fn load(path ...string) {
	// # this works only on $debug build
	// mut file := $embed_file('.env')
	// 
	// str := unsafe {
	// 	cstring_to_vstring(file.data())
	// }

	mut pa := '.env' // default value
	for p in path {
		pa = p
	}
	str := os.read_file(pa) or { panic('failed to read file $pa') }
	for line in str.split('\n') {
		if line.len < 3 {
			continue
		}
		if line.starts_with('#') {
			continue
		}
		key_val := line.split_nth('=', 2)
		os.setenv(key_val[0], key_val[1], true)
	}
}

// parse `.env` => map[string]string
//
// ```v
// import env  
//
// conf := env.parse()  
// conf["YOUR_ENV_VAR"]
// ```
//
// Example: parse()
// Example: parse("./path_to/.env")
pub fn parse(path ...string) map[string]string {
	mut pa := '.env' // default value
	for p in path {
		pa = p
	}
	str := os.read_file(pa) or { panic('failed to read file $pa') }
	mut conf := map[string]string{}
	for line in str.split('\n') {
		if line.len < 3 {
			continue
		}
		if line.starts_with('#') {
			continue
		}
		key_val := line.split_nth('=', 2)
		conf[key_val[0]] = key_val[1]
	}
	return conf
}
