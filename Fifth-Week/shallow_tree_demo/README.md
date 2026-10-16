# Shallow Tree Concept in Flutter

In Flutter and UI development, a **Shallow Tree** means keeping your widget component tree flat and avoiding overly deep nesting (avoiding "Widget Hell" where containers, rows, columns, and padding are nested 10+ levels deep). 

Keeping your tree shallow improves:
1. **Performance**: Less rebuilding overhead and faster layout passes.
2. **Readability**: Code is clean and modular.
3. **Maintainability**: Components are easy to test and reuse.

---

## 3 Ways to Build Shallow Trees Demonstrated in this Project:

### 1. Through a Class (`StatelessWidget`)
Encapsulating a UI component into its own dedicated class (`CustomButtonCard`) keeps the main `build` method clean and modular.

### 2. Through a Method (Helper Function)
Extracting repetitive UI building blocks into helper methods (`_buildMethodButton`) reduces duplicated code inside the main layout.

### 3. Through Objects (Data Models + Mapping)
Defining data objects (`ButtonItem`) and mapping them into UI lists using `.map()` creates a dynamic, shallow, and scaleable UI tree.
