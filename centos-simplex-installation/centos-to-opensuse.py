import os
from helpers import Komander
from datetime import datetime

base_path = 'packages-base.txt'
core_path = 'packages-core.txt'
pcw_path  = 'packages-platform-controller-worker.txt'

class package_info:
    def __init__(self, name=None):
        self.name = name

class zypper_search:
    def __init__(self):
        self.packages = []
    def add(self, package):
        self.packages.append(package)

date_format = datetime.now().strftime('%b-%d-%H%M%S')
results_file = open('search-results-{}.txt'.format(date_format), 'a')

# Load packages lists
with open(base_path) as base:
    base_list = base.read().split('\n')
    base_list = filter(bool, base_list)

with open(core_path) as core:
    core_list = core.read().split('\n')
    core_list = filter(bool, core_list)

with open(pcw_path) as pcw:
    pcw_list = pcw.read().split('\n')
    pcw_list = filter(bool, pcw_list)

comprehensive_list = []
comprehensive_list.extend(base_list)
comprehensive_list.extend(core_list)
comprehensive_list.extend(pcw_list)

# create search object with all similar packages names found using zypper
search = zypper_search()
for package in comprehensive_list:
    print(package)
    results_file.write('----------------------------\n')
    results_file.write('>>> CentOS Package: {}\n'.format(package))
    results_file.write('openSUSE search results:\n')
    command = "zypper se {} | sed -n '/ {} /p'".format(package, package)
    res = Komander.run(command)

    if res.retcode == 0:
        results = res.stdout.split(b'\n')
        results.remove(b'')
        for result in results:
            row = result.split(b'|')
            row = [i.strip() for i in row]
            pkg = package_info(row[1])
            search.add(pkg)
            results_file.write('{}\n'.format(pkg.name))
    else:
        results_file.write('There was an error with {}:{}\n'.format(package, res.stderr))

results_file.close()
