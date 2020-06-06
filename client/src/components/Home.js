import React from 'react';
import logo from './logo.svg';
import { Link as RouterLink } from 'react-router-dom';
import { Typography, Grid, Button } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';

const useStyles = makeStyles((theme) => ({
  root: {
    padding: theme.spacing(2),
    height: '100vh',
  },
  rootGrid: {
    height: '100%',
  },
  titleTypography: {
    fontFamily: 'Indie Flower',
  },
  logo: {
    height: '30vh',
  },
}));

function Home() {
  const classes = useStyles();

  return (
    <div className={classes.root}>
      <Grid
        container
        direction="column"
        alignItems="center"
        justify="center"
        spacing={3}
        className={classes.rootGrid}
      >
        <Grid item>
          <img src={logo} alt="logo" className={classes.logo} />
        </Grid>
        <Grid item>
          <Typography
            variant="h2"
            className={classes.titleTypography}
            align="center"
          >
            Taskerito
          </Typography>
          <Typography
            variant="h5"
            className={classes.titleTypography}
            align="center"
          >
            Manage your tasks while eating burrito.
          </Typography>
        </Grid>
        <Grid item container justify="center" spacing={1}>
          <Grid item>
            <Button
              size="large"
              variant="outlined"
              color="primary"
              component={RouterLink}
              to="/sign-up"
            >
              Sign up
            </Button>
          </Grid>
          <Grid item>
            <Button
              size="large"
              variant="contained"
              disableElevation
              color="primary"
              component={RouterLink}
              to="/sign-in"
            >
              Sign in
            </Button>
          </Grid>
        </Grid>
      </Grid>
    </div>
  );
}

export default Home;
