#!/bin/bash
set -e

echo "🔧 Running code quality checks..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Check if virtual environment is activated
if [[ "$VIRTUAL_ENV" == "" ]]; then
    print_warning "Virtual environment not detected. Consider activating your venv."
fi

# Install/update development dependencies
print_status "Installing development dependencies..."
pip install -q -r requirements-dev.txt

# Code formatting with Black
print_status "Running Black formatter..."
if black --check src/ tests/; then
    print_status "Code formatting is correct"
else
    print_warning "Code formatting issues found. Running black to fix..."
    black src/ tests/
    print_status "Code formatted"
fi

# Import sorting with isort
print_status "Checking import sorting..."
if isort --check-only src/ tests/; then
    print_status "Import sorting is correct"
else
    print_warning "Import sorting issues found. Running isort to fix..."
    isort src/ tests/
    print_status "Imports sorted"
fi

# Linting with flake8
print_status "Running flake8 linter..."
if flake8 src/ tests/; then
    print_status "No linting issues found"
else
    print_error "Linting issues found. Please fix the issues above."
    exit 1
fi

# Type checking with mypy
print_status "Running mypy type checker..."
if mypy src/; then
    print_status "Type checking passed"
else
    print_error "Type checking failed. Please fix the issues above."
    exit 1
fi

# Security scanning with bandit
print_status "Running Bandit security scanner..."
if bandit -r src/ -q; then
    print_status "No security issues found"
else
    print_warning "Security issues found. Review the output above."
fi

# Dependency security check
print_status "Checking dependencies for known vulnerabilities..."
if command -v safety &> /dev/null; then
    if safety check; then
        print_status "No known vulnerabilities in dependencies"
    else
        print_warning "Vulnerabilities found in dependencies. Consider updating."
    fi
else
    print_warning "Safety not installed. Run: pip install safety"
fi

# Check for secrets in code (basic check)
print_status "Checking for potential secrets..."
if grep -r -i -E "(password|secret|key|token|api_key)" src/ --exclude-dir=__pycache__ | grep -v "# nosec" | grep -v "TODO" | head -5; then
    print_warning "Potential secrets found in code. Review the matches above."
else
    print_status "No obvious secrets found in code"
fi

# Final status
echo ""
print_status "Code quality checks completed!"
echo ""
echo "Next steps:"
echo "  1. Run tests: python -m pytest"
echo "  2. Check coverage: python -m pytest --cov=src"
echo "  3. Run security tests: python -m pytest tests/security/"
echo ""