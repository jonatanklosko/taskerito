import React, { useState, useRef } from 'react';
import { gql, useMutation } from '@apollo/client';
import { IconButton, Fade, Grid } from '@material-ui/core';
import AddIcon from '@material-ui/icons/Add';
import UserSearch from '../UserSearch/UserSearch';

const ASSIGN_TASK = gql`
  mutation AssignTask($id: ID!, $userId: ID!) {
    assignTask(id: $id, userId: $userId) {
      successful
      result {
        id
        assignees {
          id
          username
        }
      }
    }
  }
`;

function AddAssigneeIcon({ taskId }) {
  const [searchOpen, setSearchOpen] = useState(false);
  const searchInputRef = useRef(null);

  const [assignTask, { loading }] = useMutation(ASSIGN_TASK, {
    onCompleted: () => setSearchOpen(false),
  });

  function handleAddClick() {
    setSearchOpen(!searchOpen);
  }

  function handleAssignment(user) {
    assignTask({ variables: { id: taskId, userId: user.id } });
  }

  return (
    <Grid container spacing={1}>
      <Grid item>
        <IconButton size="small" onClick={handleAddClick}>
          <AddIcon />
        </IconButton>
      </Grid>
      <Grid item>
        <Fade
          in={searchOpen}
          unmountOnExit
          onEntered={() => searchInputRef.current.focus()}
        >
          <UserSearch
            onChange={handleAssignment}
            TextFieldProps={{
              placeholder: 'User',
              size: 'small',
              inputRef: searchInputRef,
              style: { width: 200 },
              disabled: loading,
              onBlur: () => setSearchOpen(false),
            }}
          />
        </Fade>
      </Grid>
    </Grid>
  );
}

export default AddAssigneeIcon;
