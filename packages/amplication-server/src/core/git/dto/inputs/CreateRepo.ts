import { Field, InputType } from '@nestjs/graphql';
import { EnumGitProvider } from '../enums/EnumGitProvider';

@InputType({
  isAbstract: true
})
export class RepoCreateInput {
  @Field(() => String, {
    nullable: false
  })
  name!: string;
  @Field(() => Boolean, {
    nullable: false
  })
  public!: boolean;

  @Field(() => String, {
    nullable: false
  })
  appId!: string;

  @Field(() => String, {
    nullable: false
  })
  gitOrganizationId!: string;

  @Field(() => EnumGitProvider, {
    nullable: false
  })
  gitProvider!: EnumGitProvider;

  
}
