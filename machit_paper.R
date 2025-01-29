{
  "nbformat": 4,
  "nbformat_minor": 0,
  "metadata": {
    "colab": {
      "provenance": [],
      "authorship_tag": "ABX9TyMO3y+2GD0whiHwlPYZn0vH",
      "include_colab_link": true
    },
    "kernelspec": {
      "name": "ir",
      "display_name": "R"
    },
    "language_info": {
      "name": "R"
    }
  },
  "cells": [
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "view-in-github",
        "colab_type": "text"
      },
      "source": [
        "<a href=\"https://colab.research.google.com/github/sanaaria/Causal-Inference/blob/main/machit_paper.R\" target=\"_parent\"><img src=\"https://colab.research.google.com/assets/colab-badge.svg\" alt=\"Open In Colab\"/></a>"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 9,
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "tQlQWXWPQ03T",
        "outputId": "fddb78e1-43bc-4866-9f75-67bfc6979094"
      },
      "outputs": [
        {
          "output_type": "stream",
          "name": "stderr",
          "text": [
            "Installing package into ‘/usr/local/lib/R/site-library’\n",
            "(as ‘lib’ is unspecified)\n",
            "\n"
          ]
        }
      ],
      "source": [
        "install.packages(\"MatchIt\")  # در صورت نصب نبودن\n",
        "library(MatchIt)"
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "data(\"lalonde\")"
      ],
      "metadata": {
        "id": "8_zB9Tc8g9rE"
      },
      "execution_count": 10,
      "outputs": []
    },
    {
      "cell_type": "code",
      "source": [
        "colnames(lalonde)"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 34
        },
        "id": "XmQVOc2RgzUV",
        "outputId": "b17b042c-1faf-4ee8-d5a3-2e8c5ad8b17b"
      },
      "execution_count": 12,
      "outputs": [
        {
          "output_type": "display_data",
          "data": {
            "text/html": [
              "<style>\n",
              ".list-inline {list-style: none; margin:0; padding: 0}\n",
              ".list-inline>li {display: inline-block}\n",
              ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
              "</style>\n",
              "<ol class=list-inline><li>'treat'</li><li>'age'</li><li>'educ'</li><li>'race'</li><li>'married'</li><li>'nodegree'</li><li>'re74'</li><li>'re75'</li><li>'re78'</li></ol>\n"
            ],
            "text/markdown": "1. 'treat'\n2. 'age'\n3. 'educ'\n4. 'race'\n5. 'married'\n6. 'nodegree'\n7. 're74'\n8. 're75'\n9. 're78'\n\n\n",
            "text/latex": "\\begin{enumerate*}\n\\item 'treat'\n\\item 'age'\n\\item 'educ'\n\\item 'race'\n\\item 'married'\n\\item 'nodegree'\n\\item 're74'\n\\item 're75'\n\\item 're78'\n\\end{enumerate*}\n",
            "text/plain": [
              "[1] \"treat\"    \"age\"      \"educ\"     \"race\"     \"married\"  \"nodegree\" \"re74\"    \n",
              "[8] \"re75\"     \"re78\"    "
            ]
          },
          "metadata": {}
        }
      ]
    },
    {
      "cell_type": "markdown",
      "source": [
        "Exact matching"
      ],
      "metadata": {
        "id": "6eKkE9JyheQf"
      }
    },
    {
      "cell_type": "code",
      "source": [
        " m.out <- matchit(treat ~ educ +race , data = lalonde, method = \"exact\")"
      ],
      "metadata": {
        "id": "qAaDuWAUSZpw"
      },
      "execution_count": 13,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        "Subclassification\n"
      ],
      "metadata": {
        "id": "kx6V_cvPhhom"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "m.out <- matchit(treat ~ re74 + re75 + educ + race + age, data = lalonde, method = \"subclass\")"
      ],
      "metadata": {
        "id": "kVdZmQnmgrZx"
      },
      "execution_count": 15,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        "Nearest neighbor matching"
      ],
      "metadata": {
        "id": "ifgq0SV1hrrG"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "m.out <- matchit(treat ~ re74 + re75 + educ + race + age, data = lalonde, method = \"nearest\")"
      ],
      "metadata": {
        "id": "pIy6KgwAhdHZ"
      },
      "execution_count": 17,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        "Optimal matching"
      ],
      "metadata": {
        "id": "gDsxmoBeh5mZ"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "install.packages(\"optmatch\")\n",
        "library(optmatch)"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "U-REaG7rikNf",
        "outputId": "a39271b8-3ada-43fb-8a38-ceaaf5fa2877"
      },
      "execution_count": 20,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stderr",
          "text": [
            "Installing package into ‘/usr/local/lib/R/site-library’\n",
            "(as ‘lib’ is unspecified)\n",
            "\n",
            "also installing the dependency ‘rlemon’\n",
            "\n",
            "\n"
          ]
        }
      ]
    },
    {
      "cell_type": "code",
      "source": [
        " m.out <- matchit(treat ~ re74 + re75 + age + educ, data = lalonde,\n",
        " method = \"optimal\", ratio = 2)"
      ],
      "metadata": {
        "id": "h4p6I6HEh1e1"
      },
      "execution_count": 21,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        "Full matching"
      ],
      "metadata": {
        "id": "urycNukzkhhY"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "m.out <- matchit(treat ~ age + educ + race+ married +\n",
        " nodegree + re74 + re75, data = lalonde, method = \"full\")\n"
      ],
      "metadata": {
        "id": "GL-mJW2_iL3p"
      },
      "execution_count": 23,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        "Genetic matching"
      ],
      "metadata": {
        "id": "rELNS22ckkyC"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "install.packages(\"rgenoud\")\n",
        "install.packages(\"Matching\")\n",
        "library(rgenoud)\n",
        "library(Matching)"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "5h9Kknxlk6xB",
        "outputId": "7bfaec86-4e7b-4187-87c1-439602af799d"
      },
      "execution_count": 28,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stderr",
          "text": [
            "Installing package into ‘/usr/local/lib/R/site-library’\n",
            "(as ‘lib’ is unspecified)\n",
            "\n",
            "Installing package into ‘/usr/local/lib/R/site-library’\n",
            "(as ‘lib’ is unspecified)\n",
            "\n",
            "##  rgenoud (Version 5.9-0.11, Build Date: 2024-10-03)\n",
            "##  See http://sekhon.berkeley.edu/rgenoud for additional documentation.\n",
            "##  Please cite software as:\n",
            "##   Walter Mebane, Jr. and Jasjeet S. Sekhon. 2011.\n",
            "##   ``Genetic Optimization Using Derivatives: The rgenoud package for R.''\n",
            "##   Journal of Statistical Software, 42(11): 1-26. \n",
            "##\n",
            "\n",
            "\n",
            "Loading required package: MASS\n",
            "\n",
            "## \n",
            "##  Matching (Version 4.10-15, Build Date: 2024-10-14)\n",
            "##  See https://www.jsekhon.com for additional documentation.\n",
            "##  Please cite software as:\n",
            "##   Jasjeet S. Sekhon. 2011. ``Multivariate and Propensity Score Matching\n",
            "##   Software with Automated Balance Optimization: The Matching package for R.''\n",
            "##   Journal of Statistical Software, 42(7): 1-52. \n",
            "##\n",
            "\n",
            "\n"
          ]
        }
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "m.out <- matchit(treat ~ age + educ + race + married + nodegree + re74 + re75, data = lalonde, method = \"genetic\")"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "_sadnLxPkc2O",
        "outputId": "e2775334-fda0-47c0-b23c-c0f809be7303"
      },
      "execution_count": 29,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stderr",
          "text": [
            "Warning message:\n",
            "“(from Matching) The key tuning parameters for optimization were are all\n",
            "left at their default values.  The 'pop.size' option in particular\n",
            "should probably be increased for optimal results.  For details please\n",
            "see the help page and https://www.jsekhon.com”\n"
          ]
        }
      ]
    },
    {
      "cell_type": "markdown",
      "source": [
        "The general syntax is as follows. First, we use match.data() to create the matched data from\n",
        "the MatchIt output object (m.out) by excluding unmatched units from the original data, and\n",
        "including information produced by the particular matching procedure (i.e., primarily a new\n",
        "data set, but also information that may result such as weights, subclasses, or the distance\n",
        "measure).\n",
        "R> m.data <- match.data(m.out)\n",
        "where m.data is the resulting matched data. Zelig analyses all use three commands — zelig,\n",
        "setx, and sim. For example, the basic statistical analysis is performed first:\n",
        "R> z.out <- zelig(Y ~ treat + x1 + x2, model = mymodel, data = m.data)\n",
        "where Y is the outcome variable, mymodel is the selected model, and z.out is the output\n",
        "object from zelig. This output object includes estimated coefficients, standard errors, and\n",
        "other typical outputs from your chosen statistical model. Its contents can be examined via\n",
        "summary(z.out) or plot(z.out), but the idea of Zelig is that these statistical results are\n",
        "typically only intermediate quantities needed to compute your ultimate quantities of interest,\n",
        "which in the case of matching are usually causal inferences. To get these causal quantities, we\n",
        "use Zelig’s other two commands. Thus, we can set the explanatory variables at their means\n",
        "(the default) and change the treatment variable from a 0 to a 1:\n",
        "R> x.out0 <- setx(z.out0, treat = 0)\n",
        "R> x1.out0 <- setx(z.out0, treat = 1)\n",
        "and finally compute the resulting estimates of the causal effects and examine a summary:\n",
        "R> s.out0 <- sim(z.out1, x = x.out1)\n",
        "R> summary(s.out0)"
      ],
      "metadata": {
        "id": "dnqFwL86mgb_"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "install.packages(\"https://cran.r-project.org/src/contrib/Archive/Zelig/Zelig_4.2-1.tar.gz\",\n",
        "                 repos=NULL,\n",
        "                 type=\"source\")\n"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "mXVnCzZCkpai",
        "outputId": "eb1f27ed-1b61-4636-8819-5db5913bbc36"
      },
      "execution_count": 39,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stderr",
          "text": [
            "Installing package into ‘/usr/local/lib/R/site-library’\n",
            "(as ‘lib’ is unspecified)\n",
            "\n"
          ]
        }
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "install.packages(\"sandwich\")"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "SIev0bLunenF",
        "outputId": "be643378-f972-4e6b-a254-dac1f26e410d"
      },
      "execution_count": 40,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stderr",
          "text": [
            "Installing package into ‘/usr/local/lib/R/site-library’\n",
            "(as ‘lib’ is unspecified)\n",
            "\n"
          ]
        }
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "packageVersion(\"Zelig\")"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 34
        },
        "id": "vHQHihfxmeJA",
        "outputId": "57d5aa3f-0213-4c47-ce99-de0e2447cf0b"
      },
      "execution_count": 41,
      "outputs": [
        {
          "output_type": "display_data",
          "data": {
            "text/plain": [
              "[1] ‘4.2.1’"
            ]
          },
          "metadata": {}
        }
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "library(\"Zelig\")"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "_iAKecrLnR3J",
        "outputId": "6b399412-85be-4d96-9200-0b863cee13db"
      },
      "execution_count": 42,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stderr",
          "text": [
            "Loading required package: boot\n",
            "\n",
            "Loading required package: sandwich\n",
            "\n",
            "ZELIG (Versions 4.2-1, built: 2013-09-12)\n",
            "\n",
            "\n",
            "+----------------------------------------------------------------+\n",
            "|  Please refer to http://gking.harvard.edu/zelig for full       |\n",
            "|  documentation or help.zelig() for help with commands and      |\n",
            "|  models support by Zelig.                                      |\n",
            "|                                                                |\n",
            "|  Zelig project citations:                                      |\n",
            "|    Kosuke Imai, Gary King, and Olivia Lau.  (2009).            |\n",
            "|    ``Zelig: Everyone's Statistical Software,''                 |\n",
            "|    http://gking.harvard.edu/zelig                              |\n",
            "|   and                                                          |\n",
            "|    Kosuke Imai, Gary King, and Olivia Lau. (2008).             |\n",
            "|    ``Toward A Common Framework for Statistical Analysis        |\n",
            "|    and Development,'' Journal of Computational and             |\n",
            "|    Graphical Statistics, Vol. 17, No. 4 (December)             |\n",
            "|    pp. 892-913.                                                |\n",
            "|                                                                |\n",
            "|   To cite individual Zelig models, please use the citation     |\n",
            "|   format printed with each model run and in the documentation. |\n",
            "+----------------------------------------------------------------+\n",
            "\n",
            "\n",
            "\n",
            "\n",
            "Attaching package: ‘Zelig’\n",
            "\n",
            "\n",
            "The following object is masked from ‘package:utils’:\n",
            "\n",
            "    cite\n",
            "\n",
            "\n"
          ]
        }
      ]
    },
    {
      "cell_type": "code",
      "source": [],
      "metadata": {
        "id": "vuQ6Fn_Snsff"
      },
      "execution_count": null,
      "outputs": []
    }
  ]
}