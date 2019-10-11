import os
from helpers import Komander
from datetime import datetime

base_path = 'packages-base.txt'
core_path = 'packages-core.txt'
pcw_path  = 'packages-platform-controller-worker.txt'

class package_info:
    def __init__(self, centos_name=None):
        self.centos_name = centos_name
        self.opensuse_match = None
        self.opensuse_options = []

class zypper_search:
    def __init__(self):
        self.packages = []
    def add(self, package):
        self.packages.append(package)
    def print(self):
        for p in self.packages:
            results_file_success.write('{}\n'.format(p.name))


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
    command = "zypper se {} | sed -n '/ {} /p'".format(package, package)
    res = Komander.run(command)

    pkg = package_info(package)

    if res.retcode == 0:
        results = res.stdout.split(b'\n')
        results.remove(b'')
        for result in results:
            row = result.split(b'|')
            row = [i.strip() for i in row]
            pkg.opensuse_options.append(row[1])

            if package == str(row[1])[2:-1]:
                pkg.opensuse_match = row[1]
    else:
        results_file_success.write('There was an error with {}:{}\n'.format(package, res.stderr))
    search.add(pkg)


date_format = datetime.now().strftime('%b-%d-%H%M%S')
results_file_success = open('search-results-success-{}.txt'.format(date_format), 'a')
results_file_options = open('search-results-options-{}.txt'.format(date_format), 'a')
results_file_no_options = open('search-results-no-options-{}.txt'.format(date_format), 'a')
# print results
for package in search.packages:
    if package.opensuse_match:
        results_file_success.write('{}\n'.format(package.opensuse_match.decode('utf-8')))
    else:
        if not package.opensuse_options:
            # if opensuse_options is empty, it means there are no options
            results_file_no_options.write('{}\n'.format(package.centos_name))
        else:
            # send options to other file
            the_options = [x.decode('utf-8') for x in package.opensuse_options]
            results_file_options.write('{} has these options:{}\n'.format(package.centos_name, the_options))

results_file_success.close()
results_file_options.close()
results_file_no_options.close()
