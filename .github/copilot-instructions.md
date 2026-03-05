<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

# Jordan Tourism App — Copilot Instructions

This is a **Flutter** mobile application promoting tourism in Jordan.

## Project Structure
- `lib/main.dart` — App entry point and theme
- `lib/screens/` — All screen widgets (Home, Attractions, Detail, AI Assistant, Quiz)
- `lib/models/` — Data models (Attraction, QuizQuestion)
- `lib/data/` — Static data (attractions_data.dart, quiz_data.dart)
- `lib/widgets/` — Reusable widgets
- `assets/images/` — Image assets

## Tech Stack
- Flutter (Dart)
- google_fonts (Poppins font)
- audioplayers (sound feedback in quiz)
- Material 3 design system

## Design Guidelines
- Primary colour: `#8B4513` (Saddle Brown — Jordan desert tones)
- Secondary colour: `#D4A843` (Golden sand)
- Background: `#FFF8F0` (Warm white)
- AI Assistant green: `#1A6B3C`
- Quiz blue: `#1A3A6B`
- Font: Poppins (via google_fonts)

## Coding Conventions
- Use `const` constructors wherever possible
- Prefer `StatelessWidget` unless state is needed
- Keep screen files in `lib/screens/`
- Keep data files in `lib/data/`
- All text should use `GoogleFonts.poppins()`
