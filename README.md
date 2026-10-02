# Educational Platform - Summaries & Lectures

A comprehensive educational platform designed to provide university students with easy access to academic summaries, lectures, and study materials. Built with React and Material UI, the application offers a modern, responsive, and intuitive user experience.

## ✨ Features

- **Specialty & Level Selection**: Easily navigate through different majors, study years, and semesters.
- **Subject Filtering**: Filter available study materials by specific subjects.
- **Search Functionality**: Instantly search for specific summaries or lectures using a debounced search input for optimized performance.
- **Dual Content Views**: Toggle seamlessly between available 'Summaries' (الملخصات) and 'Lectures' (المحاضرات).
- **Direct Downloads**: View and download study materials directly from Google Drive or local storage.
- **Dark/Light Mode**: Full theme support with an intuitive toggle for comfortable reading in any environment.
- **Responsive Design**: Fully optimized for mobile, tablet, and desktop viewing.

## 🚀 Technologies Used

- **Frontend Framework**: React.js (v19)
- **Routing**: React Router DOM (v7)
- **UI Library**: Material UI (MUI v7)
- **Styling**: Emotion, Vanilla CSS
- **Data Fetching**: Axios with custom React Hooks
- **Icons**: MUI Icons Material
- **Typography**: Cairo font for optimal Arabic text rendering

## 📂 Project Structure

```text
src/
├── api/                  # Centralized API service layer
├── components/           # Reusable UI components (Header, Footer, SummaryCard)
├── contexts/             # React Context providers (Theme, Selection states)
├── hooks/                # Custom React hooks (useFetch)
├── pages/                # Main application routes/pages
├── theme/                # MUI Theme configurations
├── App.js                # Root application component and routing
└── index.js              # Application entry point
```

## 🛠️ Getting Started

### Prerequisites
- Node.js (v16 or higher recommended)
- npm or yarn

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   npm install
   ```

3. Start the development server:
   ```bash
   npm start
   ```

4. The application will open in your default browser at `http://localhost:3000`.

## 🌐 API Integration

The frontend connects to a robust backend service (`https://aug-backpack.runasp.net/api/v1`) to fetch structural data (Majors, Levels, Semesters, Subjects) and the actual educational content.

## 📞 Contact

For support and inquiries:
- **Email**: jebrilaabed@gmail.com
- **WhatsApp**: +972 56-767-7406
