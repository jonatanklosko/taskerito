import React from 'react';
import { Link as RouterLink, useParams } from 'react-router-dom';
import { useQuery, gql } from '@apollo/client';
import { Typography, Grid } from '@material-ui/core';
import { formatDatePart } from '../../lib/date';
import CommentList from './CommentList';
import NewComment from './NewComment';
import Loading from '../Loading/Loading';
import TaskMenu from './TaskMenu';
import PriorityChip from '../PriorityChip/PriorityChip';
import AssigneeList from './AssigneeList';

const TASK = gql`
  query Task($id: ID!) {
    task(id: $id) {
      id
      name
      description
      priority
      insertedAt
      finishedAt
      canManage
      project {
        id
        name
      }
      author {
        id
        username
      }
      comments {
        id
        content
        insertedAt
        canManage
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
  if (loading) return <Loading />;
  const { task } = data;

  return (
    <Grid container direction="column" spacing={2}>
      <Grid item>
        <Typography
          variant="body2"
          color="textSecondary"
          component={RouterLink}
          to={`/projects/${task.project.id}`}
          style={{ textDecoration: 'none' }}
        >
          {task.project.name}
        </Typography>
      </Grid>
      <Grid item container alignItems="center">
        <Grid item xs>
          <Grid container spacing={1} alignItems="center">
            <Grid item>
              <Typography variant="h5">{task.name}</Typography>
            </Grid>
            <Grid item>
              <PriorityChip priority={task.priority} />
            </Grid>
          </Grid>
          <Typography variant="body2" color="textSecondary">
            Created by @{task.author.username} on{' '}
            {formatDatePart(task.insertedAt)}
          </Typography>
        </Grid>
        {task.canManage && (
          <Grid item>
            <TaskMenu taskId={task.id} finished={!!task.finishedAt} />
          </Grid>
        )}
      </Grid>
      {task.assignees.length > 0 && <AssigneeList assignees={task.assignees} />}
      <Grid item>
        <Typography variant="subtitle1">{task.description}</Typography>
      </Grid>
      <Grid item>
        <Typography variant="h6">Comments</Typography>
      </Grid>
      <Grid item>
        <CommentList
          comments={task.comments}
          refetchQueries={[{ query: TASK, variables: { id } }]}
        />
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
