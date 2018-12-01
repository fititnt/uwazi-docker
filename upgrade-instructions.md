# Upgrade instructions
> **Attention: always make a full backup before upgrading from an older version
to a new one of Uwazi software.** Tip: the most important parts are MongoDB
database and the uploaded_documents

At the moment, uwazi-docker has commands that facilitate the first installation
of the software, but upgrades from an old version of uwazi to a new one that
involve updating the database **require following official uwazi documentation**.

- See: Upgrading Uwazi and data migrations at <https://github.com/huridocs/uwazi#upgrading-uwazi-and-data-migrations>.

Tip: see docker exec documentation at <https://docs.docker.com/engine/reference/commandline/exec/>
to undestand how to run commands inside the container that runs the uwazi and
run the commands that both update database and documents from older to the
new version.
