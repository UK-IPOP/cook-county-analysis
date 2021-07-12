TODO: Utilize the one notebook as a 'tutorial' of the codebase and analysis

TODO: update readme (important for replication!)

TODO: integrate Pronob's R script - update readme according to new makefile flow - update readme w/ requirements for project (python, r, poetry) and versions

TODO: Add tests

Improvements:

- performance:
  - specifically in geocoding, which is limited by web requests to arcgis servers
  - specifically in distance calc, which is limited by CPU (55k \* 2k) iterations
