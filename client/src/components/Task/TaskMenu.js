import React, { useState } from 'react';
import { gql, useMutation } from '@apollo/client';
import { Link as RouterLink } from 'react-router-dom';
import { IconButton, Menu, MenuItem } from '@material-ui/core';
import MoreVertIcon from '@material-ui/icons/MoreVert';
import { makeStyles } from '@material-ui/core/styles';

const useStyles = makeStyles((theme) => ({
  menuList: {
    minWidth: 150,
  },
}));

const FINISH_TASK = gql`
  mutation FinishTask($id: ID!) {
    finishTask(id: $id) {
      successful
      result {
        id
        finishedAt
      }
    }
  }
`;

const UNFINISH_TASK = gql`
  mutation UninishTask($id: ID!) {
    unfinishTask(id: $id) {
      successful
      result {
        id
        finishedAt
      }
    }
  }
`;

function TaskMenu({ taskId, finished }) {
  const classes = useStyles();
  const [anchorEl, setAnchorEl] = useState(null);

  function handleClick(event) {
    setAnchorEl(event.currentTarget);
  }

  function handleClose() {
    setAnchorEl(null);
  }

  const [finishTask] = useMutation(FINISH_TASK, {
    variables: { id: taskId },
    onCompleted: () => handleClose(),
  });

  const [unfinishTask] = useMutation(UNFINISH_TASK, {
    variables: { id: taskId },
    onCompleted: () => handleClose(),
  });

  return (
    <>
      <IconButton onClick={handleClick}>
        <MoreVertIcon />
      </IconButton>
      <Menu
        anchorEl={anchorEl}
        keepMounted
        open={!!anchorEl}
        onClose={handleClose}
        classes={{ list: classes.menuList }}
      >
        <MenuItem component={RouterLink} to={`/tasks/${taskId}/edit`}>
          Edit
        </MenuItem>
        {finished ? (
          <MenuItem onClick={() => unfinishTask()}>Mark unfinished</MenuItem>
        ) : (
          <MenuItem onClick={() => finishTask()}>Mark finished</MenuItem>
        )}
      </Menu>
    </>
  );
}

export default TaskMenu;
