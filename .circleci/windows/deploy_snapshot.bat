REM
REM Copyright (C) 2022 Vaticle
REM
REM  This program is free software: you can redistribute it and/or modify
REM  it under the terms of the GNU Affero General Public License as
REM  published by the Free Software Foundation, either version 3 of the
REM  License, or (at your option) any later version.
REM
REM  This program is distributed in the hope that it will be useful,
REM  but WITHOUT ANY WARRANTY; without even the implied warranty of
REM  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
REM  GNU Affero General Public License for more details.
REM
REM  You should have received a copy of the GNU Affero General Public License
REM  along with this program.  If not, see <https://www.gnu.org/licenses/>.
REM
REM

REM needs to be called such that software installed
REM by Chocolatey in prepare.bat is accessible
CALL refreshenv

ECHO Building and deploying windows package...
SET DEPLOY_ARTIFACT_USERNAME=%REPO_VATICLE_USERNAME%
SET DEPLOY_ARTIFACT_PASSWORD=%REPO_VATICLE_PASSWORD%

git rev-parse HEAD > version_snapshot.txt
set /p VER=<version_snapshot.txt
bazel --output_user_root=C:/b run --verbose_failures --define version=%VER% //:deploy-windows-x86_64-zip -- snapshot
IF %errorlevel% NEQ 0 EXIT /b %errorlevel%
