module env

import os

// load `.env` => map[string]string
//
// ```v
// conf := load()  
// conf["YOUR_ENV_VAR"]
// ```
//
// Example: load()
pub fn load(path ...string) map[string]string {
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
		// os.setenv(key_val[0], key_val[1], true)
	}
	return conf
}
