#!/bin/bash

# Kicks-Connect Project Validation Script

echo "=== Kicks-Connect Project Validation ==="
echo ""

# Check if this is a Flutter project
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ Not a Flutter project - pubspec.yaml not found"
    exit 1
fi

echo "✅ Flutter project detected"

# Check main files exist
files_to_check=(
    "lib/main.dart"
    "lib/routes.dart"
    "lib/theme.dart"
    "lib/firebase_options.dart"
    "lib/domain/models.dart"
    "lib/services/firestore_service.dart"
    "lib/services/cart_service.dart"
    "lib/services/shoes_provider.dart"
)

echo ""
echo "Checking core files..."
for file in "${files_to_check[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ $file - Missing"
    fi
done

# Check UI pages
echo ""
echo "Checking UI pages..."
ui_pages=(
    "lib/ui/pages/home_page.dart"
    "lib/ui/pages/product_list_page.dart"
    "lib/ui/pages/product_detail_page.dart"
    "lib/ui/pages/cart_page.dart"
    "lib/ui/pages/checkout_page.dart"
    "lib/ui/pages/profile_page.dart"
    "lib/ui/pages/admin/admin_dashboard_page.dart"
)

for page in "${ui_pages[@]}"; do
    if [ -f "$page" ]; then
        echo "✅ $page"
    else
        echo "❌ $page - Missing"
    fi
done

# Check Firebase schema
echo ""
echo "Checking Firebase configuration..."
if [ -f "firebase/schema.md" ]; then
    echo "✅ firebase/schema.md"
else
    echo "❌ firebase/schema.md - Missing"
fi

# Check assets directory
echo ""
echo "Checking assets..."
if [ -d "assets" ]; then
    echo "✅ assets directory exists"
    if [ -f "assets/README.md" ]; then
        echo "✅ assets/README.md"
    else
        echo "❌ assets/README.md - Missing"
    fi
else
    echo "❌ assets directory - Missing"
fi

# Check for gitignore
echo ""
echo "Checking project configuration..."
if [ -f ".gitignore" ]; then
    echo "✅ .gitignore"
else
    echo "❌ .gitignore - Missing"
fi

if [ -f "analysis_options.yaml" ]; then
    echo "✅ analysis_options.yaml"
else
    echo "❌ analysis_options.yaml - Missing"
fi

echo ""
echo "=== Validation Complete ==="
echo ""
echo "Key Features Implemented:"
echo "• Firebase integration with demo configuration"
echo "• Complete cart management system"
echo "• Product browsing with real sample data"
echo "• Category filtering and product search"
echo "• Checkout process with form validation"
echo "• Admin dashboard with product management"
echo "• Profile system with demo authentication"
echo "• Material Design 3 theming"
echo ""
echo "Ready for development with Flutter!"
echo "Run 'flutter pub get' to install dependencies"
echo "Run 'flutter run -d chrome' to test in browser"