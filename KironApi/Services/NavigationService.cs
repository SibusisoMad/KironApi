using DataLayer.Models;
using DataLayer.Models.Dto;
using DataLayer.Repositories;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;

namespace KironApi.Services
{
    public class NavigationService
    {
        private readonly NavigationRepository navigationRepository;
        private readonly ILogger logger;

        public NavigationService(NavigationRepository navigationRepository, ILogger<NavigationService> logger)
        {
            this.navigationRepository = navigationRepository;
            this.logger = logger;
        }

        public IEnumerable<NavigationDto> GetNavigationTree()
        {
            try
            {
                var navigations = navigationRepository.GetAllNavigations();
                var navigationTree = new List<NavigationDto>();

                var parentToChildrenMap = navigations.GroupBy(n => n.ParentID)
                                                     .ToDictionary(g => g.Key, g => g.ToList());

                if (parentToChildrenMap.TryGetValue(-1, out var rootNavigations))
                {
                    foreach (var rootNav in rootNavigations)
                    {
                        var navigationNode = new NavigationDto
                        {
                            Text = rootNav.Text,
                            Children = GetChildNavigationNodes(rootNav.ID, parentToChildrenMap)
                        };

                        navigationTree.Add(navigationNode);
                    }
                }

                return navigationTree;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while processing navigation data");
                throw;
            }
        }

        private List<NavigationDto> GetChildNavigationNodes(int parentId, Dictionary<int, List<Navigation>> parentToChildrenMap)
        {
            if (parentToChildrenMap.TryGetValue(parentId, out var childNavigations))
            {
                var childNodes = new List<NavigationDto>();

                foreach (var childNav in childNavigations)
                {
                    var childNode = new NavigationDto
                    {
                        Text = childNav.Text,
                        Children = GetChildNavigationNodes(childNav.ID, parentToChildrenMap)
                    };

                    childNodes.Add(childNode);
                }

                return childNodes;
            }

            return new List<NavigationDto>();
        }
    }
}
