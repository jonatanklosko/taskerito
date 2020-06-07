import React from 'react';
import { Link as RouterLink } from 'react-router-dom';
import { useQuery, gql } from '@apollo/client';
import logo from '../Home/logo.svg';
import { Switch, Route, Redirect } from 'react-router-dom';
import { Typography, Grid, Toolbar, Button } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';
import SignIn from '../SignIn/SignIn';
import SignUp from '../SignUp/SignUp';
import Projects from '../Projects/Projects';
import SignOutButton from './SignOutButton';
import Project from '../Project/Project';
import NewProject from '../NewProject/NewProject';
import NewTask from '../NewTask/NewTask';
import Task from '../Task/Task';
import Loading from '../Loading/Loading';

const useStyles = makeStyles((theme) => ({
  titleTypography: {
    fontFamily: 'Indie Flower',
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

const CURRENT_USER = gql`
  query CurrentUser {
    currentUser {
      id
      name
    }
  }
`;

function Navigation() {
  const classes = useStyles();
  const { data, loading, error } = useQuery(CURRENT_USER);

  if (error) return 'Something went wrong.';
  if (loading) return <Loading />;
  const { currentUser } = data;

  return (
    <>
      <Toolbar>
        <Grid container alignItems="center" spacing={1}>
          <Grid item>
            <img src={logo} alt="logo" className={classes.logo} />
          </Grid>
          <Grid item className={classes.grow}>
            <Typography variant="h3" className={classes.titleTypography}>
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
      <div className={classes.content}>
        <Switch>
          <Route exact path="/sign-in">
            <SignIn />
          </Route>
          <Route exact path="/sign-up">
            <SignUp />
          </Route>
          <Route exact path="/projects">
            <Projects />
          </Route>
          <Route exact path="/projects/new">
            <NewProject />
          </Route>
          <Route exact path="/projects/:projectId/tasks/new">
            <NewTask />
          </Route>
          <Route exact path="/projects/:id">
            <Project />
          </Route>
          <Route exact path="/tasks/:id">
            <Task />
          </Route>
          <Redirect to="/" />
        </Switch>
      </div>
    </>
  );
}

export default Navigation;
