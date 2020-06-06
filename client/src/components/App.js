import React from 'react';
import { CssBaseline } from '@material-ui/core';
import { createMuiTheme, ThemeProvider } from '@material-ui/core/styles';

import Home from './Home';

const theme = createMuiTheme({
  palette: {
    primary: {
      light: '#ff9069',
      main: '#fc5d3d',
      dark: '#c22712',
      contrastText: '#fff',
    },
    secondary: {
      light: '#484848',
      main: '#212121',
      dark: '#000000',
      contrastText: '#fff',
    },
  },
});

function App() {
  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <Home />
    </ThemeProvider>
  );
}

export default App;
