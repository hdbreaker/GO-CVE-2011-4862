# VARIABLES
TARG=sgs-enabler
PACKAGE="github.com/CVE-2011-4862"
BINARY_NAME="CVE-2011-4862"

print_success = echo -e "\e[1;32m$(1) $<\e[0m"
print_warning = echo -e "\e[1;33m$(1) $<\e[0m"
print_error = echo -e "\e[1;31m$(1) $<\e[0m"

export GOPATH=$(shell pwd)

# Default target : Do nothing
default:
	@echo "You must specify a target with this makefile"
	@echo "Usage : "
	@echo "make clean        Remove binary files"
	@echo "make install      Compile sources and build binaries"
	@echo "make test         Run all tests of your application"
	@echo "make run          Build application and run it !"

# Clean .o files and binary
clean:
	@echo "--> cleaning..."
	@go clean || (echo "Unable to clean project" && exit 1)
	@rm -rf bin/$(BINARY_NAME) 2> /dev/null
	@echo "Clean OK"

# Compile sources and build binary
install: clean
	@echo "--> installing..."
	@go install $(PACKAGE) || ($(call print_error,Compilation error) && exit 1)
	@echo "Install OK"

# Run your application
run: clean install
	@echo "--> running application..."
	@./bin/$(BINARY_NAME)

# Test your application
test:
	@echo "--> testing..."
	@go test -v $(PACKAGE)/...
