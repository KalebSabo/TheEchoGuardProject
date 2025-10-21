#!/bin/bash

# EchoGuard Project Setup Script
echo "🚀 Setting up EchoGuard Development Environment..."

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is required but not installed."
    exit 1
fi

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is required but not installed."
    exit 1
fi

# Set up Python virtual environment
echo "📦 Setting up Python virtual environment..."
cd backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements/base.txt

# Install frontend dependencies
echo "📦 Installing frontend dependencies..."
cd ../frontend
npm install

# Return to root directory
cd ..

# Set up pre-commit hooks
echo "🔧 Setting up Git hooks..."
cat > .git/hooks/pre-commit << EOF
#!/bin/bash
# Run backend linting
cd backend && source venv/bin/activate && black src/ && flake8 src/
# Run frontend linting
cd ../frontend && npm run lint
EOF

chmod +x .git/hooks/pre-commit

echo "✅ Setup complete! Ready to start development."
echo ""
echo "Next steps:"
echo "1. Activate Python environment: cd backend && source venv/bin/activate"
echo "2. Start backend: uvicorn src.main:app --reload"
echo "3. Start frontend: cd frontend && npm start"
echo "4. Or use Docker: docker-compose up"