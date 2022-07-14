import { Component } from '@angular/core';

@Component({
  selector: 'architecture-angular',
  template: `
    <div>
    
      <h3>{{curly-open 2}}title}}</h3>

      <ul class="list-group col-12">
        <li class="list-group-item" *ngFor="let link of links">
          <a class="btn btn-link btn-block" [href]="link.url" target="sample">{{curly-open 2}}link.title}}</a>
        </li>
        
      </ul>
      
    </div>
`
})
export class AppComponent {
  title = 'API Samples - Angular';

  links = [
      {{#each models}}
              { title: '{{titleize (humanize this.names)}}', url: "/api/v1/{{snake this.names}}/sample" }{{#if @last}}{{else}},{{/if}}
      {{/each}}
      ];
}

