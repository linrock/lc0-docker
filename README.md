### lc0 docker

Put credentials in `lc0-training-client-config.json` locally:

`{"User":"<username>","Pass":"<password>","Localhost":""}`

Deploy to a server with

`docker -H ssh://server-name compose up --build -d`

Run with:

./lc0-training-client-linux -backend-opts="backend=cuda-fp16"
./lc0-training-client-linux -backend-opts="cuda-fp16(gpu=1)"
