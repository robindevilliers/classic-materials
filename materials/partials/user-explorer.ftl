<div id="${id}" class="explorer-widget explorer panel ${classes}" style="${itemStyles}">
    <div class="header panel-header">

        <form class="form-inline" method="get" action="${action}">
            <div class="explorer-header-title">
                User Lookup
            </div>
            <div class="input-group">
                <div class="input-group-prepend">
                    <div class="input-group-text">Group</div>
                </div>
                <label class="sr-only" for="group">Group</label>
                <select class="form-control" id="group" name="uGroup">
                    <option value=""> -</option>
                    <#list groups as val>
                        <option <#if group == val.name>selected</#if> value="${val.name}">${val.title}</option>
                    </#list>
                </select>

                <label class="sr-only" for="username">Username</label>
                <input autocomplete="off" type="text" class="form-control" name="uUsername" id="username"
                        value="${username}" placeholder="Username">

                <label class="sr-only" for="firstName">First Name</label>
                <input autocomplete="off" type="text" class="form-control" name="uFirstName" id="firstName"
                        value="${firstName}" placeholder="First Name">

                <label class="sr-only" for="lastName">Last Name</label>
                <input autocomplete="off" type="text" class="form-control" name="uLastName" id="lastName"
                        value="${lastName}" placeholder="Last Name">

                <div class="input-group-append">
                    <button type="submit" name="uSearch" class="btn">Search</button>
                </div>
            </div>
            <#list parameters as n, v>
                <input type="hidden" name="${n}" value="${v}"/>
            </#list>
        </form>
    </div>

    <div class="explorer-body">
        <#if !values?has_content>
            <div id="explorer-no-content" class="explorer-no-content no-content">No Results</div>
        <#else>
            <div class="explorer-item-list">
                <#list values as val>
                    <a class="explorer-item-select" href="#${val.id}"
                            role="button" aria-expanded="false" aria-controls="${val.id}">
                        <span class="explorer-workflow-description">${val.username}</span>
                    </a>
                </#list>
            </div>
            <div class="explorer-item-detail" id="${id}">
                <#list values as val>
                    <div id="user-explorer-item-${val.username}" class="explorer-item " data-display="flex"
                            data-parent="#${id}">
                        <div class="explorer-title">${val.username}</div>
                        <div class="explorer-content">
                            <div class="explorer-group">
                                <div class="explorer-line">
                                    <div class="explorer-key">Title</div>
                                    <div class="explorer-value">${val.title}</div>
                                </div>

                                <div class="explorer-line">
                                    <div class="explorer-key">Firstname</div>
                                    <div class="explorer-value">${val.firstName}</div>
                                </div>

                                <div class="explorer-line">
                                    <div class="explorer-key">Lastname</div>
                                    <div class="explorer-value">${val.lastName}</div>
                                </div>
                                <div class="explorer-line">
                                    <div class="explorer-key">Last Logged In</div>
                                    <div class="explorer-value">${val.lastLoggedIn}</div>
                                </div>
                            </div>
                            <div class="explorer-group">
                                <div class="explorer-line">
                                    <div class="explorer-key">Email</div>
                                    <div class="explorer-value">${val.email}</div>
                                </div>

                                <div class="explorer-line">
                                    <div class="explorer-key">Contact Number</div>
                                    <div class="explorer-value">${val.contactNumber}</div>
                                </div>

                                <div class="explorer-line">
                                    <div class="explorer-key">Date of Birth</div>
                                    <div class="explorer-value">${val.dateOfBirth}</div>
                                </div>

                                <div class="explorer-form">

                                    <#if lookupUserMode>
                                        <form class="form-inline" method="get" action="${action}">
                                            <input type="hidden" name="principal" value="${val.username}"/>
                                            <div class="btn-group" role="group">
                                                <button type="submit" aria-label="Select" class="btn"
                                                        name="actReturn">
                                                    Select
                                                </button>
                                            </div>
                                            <#list parameters as n, v>
                                                <input type="hidden" name="${n}" value="${v}"/>
                                            </#list>
                                        </form>
                                    <#else >
                                        <form class="form-inline" method="post" action="${executeWorkflow}">
                                            <input type="hidden" name="_csrf" value="${_csrf}"/>
                                            <input type="hidden" name="_checkpoint" value="${_checkpoint}">
                                            <input type="hidden" name="username" value="${val.username}"/>
                                            <div class="btn-group" role="group">
                                                <button type="submit" aria-label="Select" class="btn"
                                                        name="uSelect" id="select-button"
                                                        onclick="${testMode?string('alert(&quot;Select clicked&quot;); event.preventDefault();','')}">
                                                    Select
                                                </button>
                                            </div>
                                        </form>
                                    </#if>
                                </div>
                            </div>
                        </div>
                    </div>
                </#list>
            </div>
        </#if>
    </div>
    <div class="explorer-footer panel-footer">
        <form class="form-inline" method="get" action="${action}">

            <#list parameters as n, v>
                <input type="hidden" name="${n}" value="${v}"/>
            </#list>

            <div class="btn-group" role="group">
                <#if !disablePrevious >
                    <button type="submit" aria-label="Previous" class="btn btn-secondary" name="actPrevious">
                        Previous
                    </button>
                </#if>
                <#if !disableNext >
                    <button type="submit" aria-label="Next" class="btn btn-secondary" name="actNext">
                        Next
                    </button>
                </#if>
            </div>
        </form>

        <#if lookupUserMode>
            <form class="form-inline" method="get" action="${action}">

                <#list parameters as n, v>
                    <input type="hidden" name="${n}" value="${v}"/>
                </#list>
                <div class="btn-group" role="group">
                    <button type="submit" aria-label="Cancel" class="btn btn-secondary"
                            name="actReturn">
                        Cancel
                    </button>
                </div>
            </form>
        <#else >
            <form class="form-inline" method="post" action="${cancelExecuteWorkflow}">
                <input type="hidden" name="_csrf" value="${_csrf}"/>
                <input type="hidden" name="_checkpoint" value="${_checkpoint}">
                <div class="btn-group" role="group">
                    <button type="submit" aria-label="Cancel" class="btn btn-secondary"
                            onclick="${testMode?string('alert(&quot;Select clicked&quot;); event.preventDefault();','')}"
                            name="actReturn">
                        Cancel
                    </button>
                </div>
            </form>
        </#if>
    </div>
</div>
