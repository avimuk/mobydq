import React from 'react';

import { Query } from 'react-apollo';
import UserGroupRepository from '../../repository/UserGroupRepository';
import { GraphQLError } from './../Error/GraphQLError';

import NotFoundComponent from '../Error/NotFoundComponent';

import { EnhancedForm } from '../Form/Form';
import EnhancedUserGroupForm from './UserGroupForm';

export const UserGroupUpdateForm = ({ ...props }) => <Query query={UserGroupRepository.display()} variables={{ 'id': props.match.params.id }}>
  {({ loading, error, data }) => {
    if (typeof UserGroupRepository.display !== 'function') {
      throw new TypeError('Repository must implement update function.');
    }
    if (loading) {
      return <GraphQLError error={error}/>;
    }
    if (error) {
      return <p>Error :(</p>;
    }
    return (
      data.UserGroupById === null
        ? <NotFoundComponent/>
        : <EnhancedForm ComponentRepository={UserGroupRepository} FormComponent={EnhancedUserGroupForm}
          afterSaveRoute="/user-group/" title="Edit User Group" initialFieldValues={data.userGroupById} {...props}/>
    );
  }}
</Query>;
