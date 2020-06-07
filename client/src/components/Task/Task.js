import React from 'react';
import { useParams } from 'react-router-dom';
import { useQuery, gql } from '@apollo/client';
import { Typography, Grid, LinearProgress, Chip } from '@material-ui/core';
import { formatDatePart } from '../../lib/date';
import CommentList from './CommentList';
import NewComment from './NewComment';

const TASK = gql`
  query Task($id: ID!) {
    task(id: $id) {
      id
      name
      description
      priority
      insertedAt
      author {
        id
        username
      }
      comments {
        id
        content
        insertedAt
        author {
          id
          username
        }
      }
      assignees {
        id
        username
      }
    }
  }
`;

function Task() {
  const { id } = useParams();
  const { data, loading, error } = useQuery(TASK, { variables: { id } });

  if (error) return 'Something went wrong.';
  if (loading) return <LinearProgress />;
  const { task } = data;

  return (
    <Grid container direction="column" spacing={2}>
      <Grid item container alignItems="center">
        <Grid item xs>
          <Typography variant="h5">{task.name}</Typography>
          <Typography variant="body2" color="textSecondary">
            Created by @{task.author.username} on{' '}
            {formatDatePart(task.insertedAt)}
          </Typography>
        </Grid>
      </Grid>
      <Grid item>
        <Typography variant="subtitle1">{task.description}</Typography>
      </Grid>
      {task.assignees.length > 0 && (
        <Grid item>
          {task.assignees.map((assignee) => (
            <Chip
              key={assignee.id}
              size="small"
              label={`@${assignee.username}`}
              variant="outlined"
              color="primary"
            />
          ))}
        </Grid>
      )}
      <Grid item>
        <Typography variant="h6">Comments</Typography>
      </Grid>
      <Grid item>
        <CommentList comments={task.comments} />
      </Grid>
      <Grid item>
        <NewComment
          taskId={task.id}
          refetchQueries={[{ query: TASK, variables: { id } }]}
        />
      </Grid>
    </Grid>
  );
}

export default Task;
