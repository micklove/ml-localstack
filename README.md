## Project details
Project will contain a basic localstack example.

## Running
The lambda src code is in the `src` folder.

+ Package with `make package`.
+ Run localstack with `make ls-up`
+ Invoke the lambda, now deployed in localstack, with  `make ls-invoke`

## Help file
Run `make help`
```bash
command-version-info Get versions of the various commands, ignore some commands that have no --version flag
dump-debug           Dump all vars, for debugging. Similar to printvars, but easier to read.
dump                 Dump vars to stdout
get-debug-vars       Dump vars, in plain text (nb: - using ! for delimiting the output)
help                 This help.
ls-invoke            Invoke the lambda, now running in localstack, echo the response with jq
ls-logs              View the logs for the localstack container
ls-stop              Stop localstack, without losing container
ls-up                Start localstack container
package              package the lambda files
printvars            Print ALL environment variables, use only for debugging.
update               update the lambda source
validate-env         Validate, early, that the commands required by this makefile are available in the current env.
```
