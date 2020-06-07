import React from 'react';
import { Link as RouterLink } from 'react-router-dom';
import logo from '../Home/logo.svg';
import { Typography, Grid, Toolbar, Button } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';
import SignOutButton from './SignOutButton';

const useStyles = makeStyles((theme) => ({
  title: {
    fontFamily: 'Indie Flower',
    textDecoration: 'none',
    color: 'inherit',
  },
  logo: {
    height: '48px',
  },
  content: {
    padding: theme.spacing(3),
  },
  grow: {
    flexGrow: 1,
  },
}));

function Layout({ currentUser, children }) {
  const classes = useStyles();

  return (
    <>
      <Toolbar>
        <Grid container alignItems="center" spacing={1}>
          <Grid item>
            <img src={logo} alt="logo" className={classes.logo} />
          </Grid>
          <Grid item className={classes.grow}>
            <Typography
              variant="h3"
              className={classes.title}
              component={RouterLink}
              to="/"
            >
              Taskerito
            </Typography>
          </Grid>
          {currentUser && (
            <>
              <Grid item>
                <Button size="small" component={RouterLink} to="/projects">
                  Projects
                </Button>
              </Grid>
              <Grid item>
                <SignOutButton />
              </Grid>
            </>
          )}
        </Grid>
      </Toolbar>
      <div className={classes.content}>{children}</div>
    </>
  );
}

export default Layout;
