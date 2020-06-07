import React from 'react';
import { Switch, Route, Redirect } from 'react-router-dom';
import { useQuery, gql } from '@apollo/client';
import Loading from '../Loading/Loading';
import Home from '../Home/Home';
import SignIn from '../SignIn/SignIn';
import SignUp from '../SignUp/SignUp';
import Projects from '../Projects/Projects';
import Project from '../Project/Project';
import NewProject from '../NewProject/NewProject';
import NewTask from '../NewTask/NewTask';
import Task from '../Task/Task';
import Layout from '../Layout/Layout';

const CURRENT_USER = gql`
  query CurrentUser {
    currentUser {
      id
      name
    }
  }
`;

function Navigation() {
  const { data, loading, error } = useQuery(CURRENT_USER);

  if (error) return 'Something went wrong.';
  if (loading) return <Loading />;
  const { currentUser } = data;

  return (
    <Switch>
      <Route exact path="/">
        <Home currentUser={currentUser} />
      </Route>
      <Route>
        <Layout currentUser={currentUser}>
          {!currentUser ? (
            <Switch>
              <Route exact path="/sign-in">
                <SignIn />
              </Route>
              <Route exact path="/sign-up">
                <SignUp />
              </Route>
              <Redirect to="/" />
            </Switch>
          ) : (
            <Switch>
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
              <Redirect to="/projects" />
            </Switch>
          )}
        </Layout>
      </Route>
    </Switch>
  );
}

export default Navigation;
