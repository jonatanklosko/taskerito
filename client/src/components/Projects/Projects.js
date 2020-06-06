import React, { useState } from 'react';
import { useHistory } from 'react-router-dom';
import { useQuery, gql } from '@apollo/client';
import { Grid, LinearProgress, Tabs, Tab, Paper } from '@material-ui/core';
import ProjectList from './ProjectList';

const PROJECTS = gql`
  query Projects {
    projects {
      ...projectFields
    }
    currentUser {
      id
      projects {
        ...projectFields
      }
    }
  }

  fragment projectFields on Project {
    id
    name
    description
  }
`;

function Projects() {
  const history = useHistory();
  const [tab, setTab] = useState('all');
  const { data, loading, error } = useQuery(PROJECTS);

  if (error) return 'Something went wrong.';
  if (loading) return <LinearProgress />;
  const { projects, currentUser } = data;

  const selectedProjects = tab === 'own' ? currentUser.projects : projects;

  function handleTabChange(event, value) {
    if (value === 'new') {
      history.push('/projects/new');
    } else {
      setTab(value);
    }
  }

  return (
    <Grid container direction="column" spacing={2}>
      <Grid item>
        <Tabs value={tab} onChange={handleTabChange}>
          <Tab value="all" label="All projects" />
          {currentUser.projects.length > 0 && (
            <Tab value="own" label="My projects" />
          )}
          <Tab value="new" label="New project" />
        </Tabs>
      </Grid>
      <Grid item>
        <Paper>
          <ProjectList projects={selectedProjects} />
        </Paper>
      </Grid>
    </Grid>
  );
}

export default Projects;
