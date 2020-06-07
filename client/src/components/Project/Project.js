import React from 'react';
import { useParams } from 'react-router-dom';
import { useQuery, gql } from '@apollo/client';
import { Typography, Grid, LinearProgress } from '@material-ui/core';
import { formatDatePart } from '../../lib/date';
import TasksBoard from './TasksBoard';
import ProjectMenu from './ProjectMenu';

const PROJECT = gql`
  query Project($id: ID!) {
    project(id: $id) {
      id
      name
      description
      insertedAt
      canManage
      author {
        id
        username
      }
      tasks {
        id
        name
        assignees {
          id
          username
        }
        finishedAt
        insertedAt
      }
    }
  }
`;

function Project() {
  const { id } = useParams();
  const { data, loading, error } = useQuery(PROJECT, { variables: { id } });

  if (error) return 'Something went wrong.';
  if (loading) return <LinearProgress />;
  const { project } = data;

  return (
    <Grid container direction="column" spacing={2}>
      <Grid item container alignItems="center">
        <Grid item xs>
          <Typography variant="h5">{project.name}</Typography>
          <Typography variant="body2" color="textSecondary">
            Created by @{project.author.username} on{' '}
            {formatDatePart(project.insertedAt)}
          </Typography>
        </Grid>
        {project.canManage && (
          <Grid item>
            <ProjectMenu projectId={project.id} />
          </Grid>
        )}
      </Grid>
      <Grid item>
        <Typography variant="subtitle1">{project.description}</Typography>
      </Grid>
      <Grid item>
        <TasksBoard tasks={project.tasks} />
      </Grid>
    </Grid>
  );
}

export default Project;
