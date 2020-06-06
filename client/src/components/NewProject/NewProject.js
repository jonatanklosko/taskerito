import React from 'react';
import { useHistory } from 'react-router-dom';
import { useMutation, gql } from '@apollo/client';
import projectImage from './project.svg';
import CenteredFormContainer from '../CenteredFormContainer/CenteredFormContainer';
import ProjectForm from './ProjectForm';

const CREATE_PROJECT = gql`
  mutation CreateProject($input: ProjectInput!) {
    createProject(input: $input) {
      successful
      result {
        id
      }
    }
  }
`;

function NewProject() {
  const history = useHistory();
  const [createProject, { data, loading }] = useMutation(CREATE_PROJECT, {
    onCompleted: ({ createProject: { successful, result } }) => {
      if (successful) {
        history.push(`/projects/${result.id}`);
      }
    },
  });

  return (
    <CenteredFormContainer svgImage={projectImage} title="New project">
      <ProjectForm
        disabled={loading}
        failed={data && !data.createProject.successful}
        onSubmit={(data) => createProject({ variables: { input: data } })}
      />
    </CenteredFormContainer>
  );
}

export default NewProject;
