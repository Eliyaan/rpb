#!/usr/bin/env -S v

// Note: The shebang line above, associates the .vsh file to V on Unix-like systems,
// so it can be run just by specifying the path to the .vsh file, once it's made
// executable, using `chmod +x deploy.vsh`, i.e. after that chmod command, you can
// run the .vsh script, by just typing its name/path like this: `./deploy.vsh`

println('Starting to update the repos')

backup_dir := home_dir() + '/backups'
println('Backup folder: ${backup_dir}')
chdir(backup_dir)!

for project in ls(backup_dir)! {
	chdir(backup_dir + '/' + project)!
	res := execute('git pull')
	if res.exit_code == 0 {
		println('---------- Successful: ${project} ----------')
		println(res.output)
	} else {
		eprintln('---------- Fail: ${project} ----------')
		eprintln(res.output)
	}
}

println('Finished!')
