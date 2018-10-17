#!/bin/bash

# define action usage commands
usage() { echo "Usage: $0 [-v \"version\"]" >&2; exit 1; }

# set option arguments to variables and echo usage on failures
version=
while getopts ":v:" o; do
  case "${o}" in
    v)
      version="${OPTARG}"
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      usage
      ;;
    *)
      usage
      ;;
  esac
done

if [ -z "$version" ]; then
  echo "Version not specified" >&2
  exit 2
fi

changeVersionCommand="mvn versions:set -DnewVersion=${version}"
changeParentVersionCommand="mvn versions:update-parent -DallowSnapshots=true -DparentVersion=${version}"
mvnInstallCommand="mvn clean install"

(cd features && $changeVersionCommand)
if [ $? -ne 0 ]; then echo "Failed to change maven version on \"features\" folder" >&2; exit 3; fi
(cd features  && $changeParentVersionCommand)
if [ $? -ne 0 ]; then echo "Failed to change maven parent versions in \"features\" folder" >&2; exit 3; fi
(cd features/cit-quickstart-wizard && $changeVersionCommand)
if [ $? -ne 0 ]; then echo "Failed to change maven version on \"features/cit-quickstart-wizard\" folder" >&2; exit 3; fi
sed -i 's/\(<version>\).*\(<\/version>\)/\1'${version}'\2/g' features/cit-quickstart-wizard/feature.xml
if [ $? -ne 0 ]; then echo "Failed to change version in \"features/cit-quickstart-wizard/feature.xml\"" >&2; exit 3; fi
(cd features/cit-task && $changeVersionCommand)
if [ $? -ne 0 ]; then echo "Failed to change maven version on \"features/cit-task\" folder" >&2; exit 3; fi
sed -i 's/\(<version>\).*\(<\/version>\)/\1'${version}'\2/g' features/cit-task/feature.xml
if [ $? -ne 0 ]; then echo "Failed to change version in \"features/cit-task/feature.xml\"" >&2; exit 3; fi

(cd packages  && $changeVersionCommand)
if [ $? -ne 0 ]; then echo "Failed to change maven version on \"packages\" folder" >&2; exit 3; fi
(cd packages  && $changeParentVersionCommand)
if [ $? -ne 0 ]; then echo "Failed to change maven parent versions in \"packages\" folder" >&2; exit 3; fi
(cd packages/cit-quickstart  && $changeVersionCommand)
if [ $? -ne 0 ]; then echo "Failed to change maven version on \"packages/cit-quickstart\" folder" >&2; exit 3; fi
(cd packages/cit-quickstart-linux  && $changeVersionCommand)
if [ $? -ne 0 ]; then echo "Failed to change maven version on \"packages/cit-quickstart-linux\" folder" >&2; exit 3; fi
find packages/cit-quickstart/src/main/application/repository/packages/ -regex ".*\.mark" -exec sed -i 's/\-[0-9\.]*[0-9]\(\-SNAPSHOT\|\(\.\.\)\)/-'${version}'\2/g' {} +

sed -i 's/\-[0-9\.]*\(\-SNAPSHOT\|\(\-\|\.zip$\|\.bin$\|\.jar$\)\)/-'${version}'\2/g' build.targets
if [ $? -ne 0 ]; then echo "Failed to change versions in \"build.targets\" file" >&2; exit 3; fi
