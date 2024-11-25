return {
    "L3MON4D3/LuaSnip", -- LuaSnip plugin
    config = function()
        local ls = require("luasnip") -- Load LuaSnip
        local s = ls.snippet -- Define snippet
        local t = ls.text_node -- Define text node
        local i = ls.insert_node -- Define insert node

        -- Add custom snippets (e.g., CMakeLists.txt snippet)
        ls.add_snippets("text", {
            s("cmakelist", {
                t({ "cmake_minimum_required(VERSION " }),
                i(1, "3.5.0"), -- Placeholder for CMake version
                t({ ")", "project(" }),
                i(2, "ProjectName"), -- Placeholder for project name
                t({ " VERSION " }),
                i(3, "0.1.0"), -- Placeholder for project version
                t({ " LANGUAGES C CXX)", "" }),
                t({ "", "add_executable(" }),
                i(4, "main"), -- Placeholder for executable name
                t({ " " }),
                i(5, "main.cpp"), -- Placeholder for source file
                t({ ")", "" }),
                t({ "", "include(CTest)" }),
                t({ "", "enable_testing()", "" }),
                t({ "", "set(CPACK_PROJECT_NAME ${PROJECT_NAME})" }),
                t({ "", "set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})", "" }),
                t({ "include(CPack)" }),
            }),
        })

        -- C++ Snippets
        ls.add_snippets("cpp", {
            -- Header guard
            s("guard", {
                t("#ifndef "),
                i(1, "HEADER_NAME"), -- Placeholder for header name
                t({ "", "#define " }),
                i(2, "HEADER_NAME"), -- Same placeholder for consistency
                t({ "", "" }),
                i(0), -- Final insertion point
                t({ "", "#endif // " }),
                i(3, "HEADER_NAME"), -- Match the header name
            }),

            -- Class definition
            s("class", {
                t({ "class " }),
                i(1, "ClassName"), -- Placeholder for class name
                t({ " {", "public:", "" }),
                t({ "    " }),
                i(2, "// Constructor and Destructor"),
                t({ "", "    " }),
                i(3, "ClassName();"), -- Constructor placeholder
                t({ "", "    " }),
                i(4, "~ClassName();"), -- Destructor placeholder
                t({ "", "", "private:", "" }),
                i(5, "// Private members"),
                t({ "", "};" }),
            }),

            -- Include guard + Class combination
            s("hpp", {
                t("#ifndef "),
                i(1, "CLASS_HEADER"), -- Placeholder for header name
                t({ "", "#define " }),
                i(2, "CLASS_HEADER"),
                t({ "", "", "class " }),
                i(3, "ClassName"),
                t({ " {", "public:", "" }),
                t({ "    " }),
                i(4, "// Constructor and Destructor"),
                t({ "", "    " }),
                i(5, "ClassName();"),
                t({ "", "    " }),
                i(6, "~ClassName();"),
                t({ "", "", "private:", "" }),
                i(7, "// Private members"),
                t({ "", "};", "", "#endif // " }),
                i(8, "CLASS_HEADER"),
            }),

            -- Arithmetic Operators
            s("operator+", {
                t("T operator+("),
                i(1, "const T& other"),
                t({ ") const {", "    " }),
                t("// Add your implementation here"),
                t({ "", "}" }),
            }),

            s("operator-", {
                t("T operator-("),
                i(1, "const T& other"),
                t({ ") const {", "    " }),
                t("// Add your implementation here"),
                t({ "", "}" }),
            }),

            s("operator*", {
                t("T operator*("),
                i(1, "const T& other"),
                t({ ") const {", "    " }),
                t("// Add your implementation here"),
                t({ "", "}" }),
            }),

            s("operator/", {
                t("T operator/("),
                i(1, "const T& other"),
                t({ ") const {", "    " }),
                t("// Add your implementation here"),
                t({ "", "}" }),
            }),

            -- Relational Operators
            s("operator==", {
                t("bool operator==("),
                i(1, "const T& other"),
                t({ ") const {", "    " }),
                t("// Add your comparison logic here"),
                t({ "", "}" }),
            }),

            s("operator!=", {
                t("bool operator!=("),
                i(1, "const T& other"),
                t({ ") const {", "    " }),
                t("// Add your comparison logic here"),
                t({ "", "}" }),
            }),

            s("operator<", {
                t("bool operator<("),
                i(1, "const T& other"),
                t({ ") const {", "    " }),
                t("// Add your comparison logic here"),
                t({ "", "}" }),
            }),

            s("operator>", {
                t("bool operator>("),
                i(1, "const T& other"),
                t({ ") const {", "    " }),
                t("// Add your comparison logic here"),
                t({ "", "}" }),
            }),

            s("operator<=", {
                t("bool operator<=("),
                i(1, "const T& other"),
                t({ ") const {", "    " }),
                t("// Add your comparison logic here"),
                t({ "", "}" }),
            }),

            s("operator>=", {
                t("bool operator>=("),
                i(1, "const T& other"),
                t({ ") const {", "    " }),
                t("// Add your comparison logic here"),
                t({ "", "}" }),
            }),

            -- Assignment Operators
            s("operator=", {
                t("T& operator=("),
                i(1, "const T& other"),
                t({ ") {", "    " }),
                t("// Add your assignment logic here"),
                t({ "", "    return *this;", "}" }),
            }),

            s("operator+=", {
                t("T& operator+=("),
                i(1, "const T& other"),
                t({ ") {", "    " }),
                t("// Add your addition-assignment logic here"),
                t({ "", "    return *this;", "}" }),
            }),

            s("operator-=", {
                t("T& operator-=("),
                i(1, "const T& other"),
                t({ ") {", "    " }),
                t("// Add your subtraction-assignment logic here"),
                t({ "", "    return *this;", "}" }),
            }),

            s("operator*=", {
                t("T& operator*=("),
                i(1, "const T& other"),
                t({ ") {", "    " }),
                t("// Add your multiplication-assignment logic here"),
                t({ "", "    return *this;", "}" }),
            }),

            s("operator/=", {
                t("T& operator/=("),
                i(1, "const T& other"),
                t({ ") {", "    " }),
                t("// Add your division-assignment logic here"),
                t({ "", "    return *this;", "}" }),
            }),

            -- Stream Operators
            s("operator<<", {
                t("friend std::ostream& operator<<(std::ostream& os, const T& obj) {"),
                t({ "", "    " }),
                t("// Add your stream output logic here"),
                t({ "", "    return os;", "}" }),
            }),

            s("operator>>", {
                t("friend std::istream& operator>>(std::istream& is, T& obj) {"),
                t({ "", "    " }),
                t("// Add your stream input logic here"),
                t({ "", "    return is;", "}" }),
            }),
        })
    end,
}
