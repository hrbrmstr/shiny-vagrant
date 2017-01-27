A Vagrant configuration and various other setup components to make it easier to build, configure and test Shiny apps in a Vagrant virtualbox VM.

Testing from within RStudio is great but having a standalone environment you can tear down and build up again helps weed out dependencies you didn't know you needed and ensures the Shiny code runs on at least two platforms.

I don't "do Shiny" for a living, so this whole type of thing may already exist and you may have better ways to do all or part of it. If this is totally duplicative work, def drop an issue so we can point folks to better resources. If you've got a better way to do anything here see the **Contributing** section and destroy at will.

### What's in the box?

- `Vagrantfile` contains the [Vagrant](https://www.vagrantup.com/) config script. That means you need Vagrant installed and it's beyond the scope of this project to teach you how to do that since there are dozens of "how-to"'s for that. Out-of-the-box Vagrant uses [VirtualBox](https://www.virtualbox.org/wiki/VirtualBox) to orchestrate virtual machines. It's also beyond the scope of this project to teach you how to get VirtualBox up and running and there are also dozens of "how-to"'s for it as well. If you haven't worked both VirtualBox and Vagrant you need to pause now and play a bit with them to get a feel for what they do.

- `setup_base.sh` is the core R & Shiny setup script. It provisions the Ununtu 14.04 VM with a functional Shiny environment. Try not to tweak that as that's what the next script is for.

- `setup_custom.sh` is where you _go crazy_. Add Linux packages you need. Add R packages you need. Add configurations you need. The included script does all that and even provdies some fonts. I'll probably get a take-down notice for the ones in the `/fonts` directory but they used to come with the msft core fonts Ubuntu package and don't now and I needed them for a project and figured it'd one more thing to demo.

- `update_pkg.sh` is a crazy idea I had. I tend to provide a support for a Shiny app that wraps any custom functions for that Shiny app in it. There's one in this repo in `packages/` named (boringly) `CustomSupportPkg`. The `update_pkg.sh` script installs that package everytime `vagrant up` is run. It also copies over a custom Shiny server configuration file that points to the Vagrant directory you're reading this in. It also redirects the Shiny Server logs to the `logs/` directory so you don't have to go into the VM to view the logs. 

- `index.html` / `css/` provides a mini-HTML front-end to the `apps/` directory (where your apps are!). Use 'em. Trash 'em. Modify 'em. They're pretty simple to figure out and definitely easy to rip/replace.

Note that the `hello` app has been modified to use a function from the `CustomSupportPkg`.

### What do I do first?

Clone the repo! Note that the `.gitignore` will avoid including the binary VM images in any repo you end up pushing it to.

### What do I do next?

Out of the box (i.e. with no changes) you should be able to clone this repo, `cd` into the directory and execute `vagrant up`. That should take a bit as it does the initial provisioning. When it's done you should be able to go to `http://localhost:3838` and see a button you can click on to run the "hello" app.

### Then what do I do?

1. Customize `ui.R` and `server.R` in `apps/hello` and live-refresh them (no need to restart the VM)
2. Add an app and a button (make a copy of `hello` to play with how to do that). This is also live-refreshable
3. Rip-and-replace `CustomSupportPkg` with your own and modify the scripts/apps accordingly, but then do item (4)
4. Do `vagrant halt` and `vagrant up` to re-provison your custom package and restart the shiny server
5. Break one of the apps and look at the logs in `logs/`

### Why not Docker?

Vagrant translates well to provisioning to full on cloud environments and even into [Terraform](https://www.terraform.io/) environments. You can easily turn this into a Docker configuraiton. Oh, and Vagrant can provision Docker, so this is a nice over-arching way to build out VMs and containers for testing.

You can also replace VirtualBox with VMware (or with real cloud servers). Some details may need to be tweaked a bit (see **Contributing**) but it'll be a good base framework to build on.

### Something is broken!

This is likely. I extrapolated this from a work project and did my best to make it generic, but I've only done light testing on this on a few systems (all successful). 

If you do run into problems, file an issue with sufficient detail to understand your environment and (preferably) replicate the issue.

### Contributing

Read the doc in the repo.

Basically, be cool & kind and contribute as you'd like in that context.

Some ideas:

- Programmatically generate `index.html` from the apps in `apps/`
- Add some more robust example apps
- Add some more robust example support packages
- Add an example of a _gnarly_ configuration item for `setup_custom.sh` that took you forever to figure out
- Create better documentation that what's in this "meh" README
- Add a way to auto-determine current Shiny Server version and then automation to install/update that
- Make prettier app launcher base `index.html` (though I'd like to keep a non-JS & minimal CSS framework)
- Add VMware orchestration. VirtualBox is free but I like VMware Fusion VMs on macOS, so I'll prbly get to this soon.
- Add "cloud" orchestration