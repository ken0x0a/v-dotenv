# dotenv

**dotenv** for Vlang.

## Installation

```sh
v install ken0x0a/dotenv
```

## Usage

- `load`

```v
import env  
import os  

env.load()  
os.getenv("YOUR_ENV_VAR")
```

- `parse`

```v
conf := env.parse()  
conf["YOUR_ENV_VAR"]

// or
conf := env.parse('path/to/.env')  
conf["YOUR_ENV_VAR"]
```

